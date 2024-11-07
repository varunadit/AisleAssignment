//
//  APIClient.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//

import Dependencies
import DependenciesMacros
import Foundation
import SharedModels
import ComposableArchitecture

@DependencyClient
public struct APIClient: Sendable {
    
    static let baseURL: String = "https://app.aisle.co/V1"
    nonisolated(unsafe) static var authToken: String = ""
    public var postPhoneNumber: @Sendable (PhoneNumber) async throws -> Result<PhoneNumberResponse, Error>
    public var postOTP: @Sendable (OTPVerification) async throws -> Result<OTPVerificationResponse, Error>
    public var getProfileList: @Sendable () async throws -> Result<ProfileListResponse, Error>
}

enum APIError: Error {
    case invalidResponse
    case badRequest
    case unauthorized
    case notFound
    case internalServerError
    case unknown
    case decodingError
    case encodingError
}

extension APIClient: DependencyKey {
    public static let liveValue = Self(
        postPhoneNumber: { phoneNumber in
            let urlString = Self.baseURL + "/users" + "/phone_number_login"
            guard let url = URL(string: urlString) else {
                return .failure(URLError(.badURL))
            }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let requestBody = try? JSONEncoder().encode(phoneNumber)
            guard let body = requestBody else {
                return .failure(APIError.encodingError)
            }
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(PhoneNumberResponse.self, from: data)
                    return .success(decodedResponse)
                } catch {
                    throw APIError.decodingError
                }
                
            case 400:
                throw APIError.badRequest
            case 401:
                throw APIError.unauthorized
            case 404:
                throw APIError.notFound
            case 500:
                throw APIError.internalServerError
            default:
                throw APIError.unknown
            }
            
        },
        postOTP: { otpVerification in
            let urlString = Self.baseURL + "/users" + "/verify_otp"
            guard let url = URL(string: urlString) else {
                return .failure(URLError(.badURL))
            }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let requestBody = try? JSONEncoder().encode(otpVerification)
            guard let body = requestBody else {
                return .failure(APIError.encodingError)
            }
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(OTPVerificationResponse.self, from: data)
                    if let token = decodedResponse.token {
                        Self.authToken = token
                        UserDefaults.standard.set(token, forKey: "authToken")
                        return .success(decodedResponse)
                    } else {
                        return .failure(APIError.unauthorized)
                    }
                    
                } catch {
                    throw APIError.decodingError
                }
                
            case 400:
                throw APIError.badRequest
            case 401:
                throw APIError.unauthorized
            case 404:
                throw APIError.notFound
            case 500:
                throw APIError.internalServerError
            default:
                throw APIError.unknown
            }
        }, getProfileList: {
            let urlString = Self.baseURL + "/users" + "/test_profile_list"
            guard let url = URL(string: urlString) else {
                return .failure(URLError(.badURL))
            }
            var request = URLRequest(url: url)
            request.setValue(Self.authToken, forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(ProfileListResponse.self, from: data)
                    return .success(decodedResponse)
                } catch {
                    throw APIError.decodingError
                }
                
            case 400:
                throw APIError.badRequest
            case 401:
                throw APIError.unauthorized
            case 404:
                throw APIError.notFound
            case 500:
                throw APIError.internalServerError
            default:
                throw APIError.unknown
            }
        }
    )
}

extension APIClient {
    public static let previewValue = Self (
        postPhoneNumber: { _ in
            return .success(
                PhoneNumberResponse(status: true)
            )
        },
        postOTP: { _ in
            return .success(
                OTPVerificationResponse(token: "")
            )
        },
        getProfileList: { 
            return .success(
                ProfileListResponse.mockProfileListResponse
            )
        }
    )
}

extension DependencyValues {
    public var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}
