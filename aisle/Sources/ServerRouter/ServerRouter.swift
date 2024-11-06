//
//  ServerRouter.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//
import Foundation
import URLRouting
import SharedModels

public struct ServerRouter {
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    
    public init(decoder: JSONDecoder = .init(), encoder: JSONEncoder = .init()) {
        self.decoder = decoder
        self.encoder = encoder
    }
    
    public var body: some Router<ServerRoute> {
        OneOf {
            Route(.case(ServerRoute.authenticate)) {
                Path {
                    "users"
                }
                Parse(.memberwise(ServerRoute.Authenticate.init(route:))) {
                    self.authenticationRouter
                }
            }
            Route(.case(ServerRoute.api)) {
                Path {
                    "users"
                }
                Parse(.memberwise(ServerRoute.API.init(authToken: route:))) {
                    Headers {
                        Field("Authorization", .string, default: "")
                    }
                    Route(.case(ServerRoute.API.Route.profileList)) {
                        Path {
                            "test_profile_list"
                        }
                    }
                }
            }
        }
        .eraseToAnyParserPrinter()
    }
    
    @ParserBuilder<URLRequestData>
    var authenticationRouter: AnyParserPrinter<URLRequestData, ServerRoute.Authenticate.Route> {
        let authRouter = OneOf {
            Route(.case(ServerRoute.Authenticate.Route.requestOTP)) {
                Method.post
                Path {
                    "phone_number_login"
                }
                Body(.json(PhoneNumber.self))
            }
            Route(.case(ServerRoute.Authenticate.Route.verifyOTP)) {
                Method.post
                Path {
                    "verify_otp"
                }
                Body(.json(OTPVerification.self))
            }
        }

        
        
        authRouter
            .eraseToAnyParserPrinter()
    }
}
