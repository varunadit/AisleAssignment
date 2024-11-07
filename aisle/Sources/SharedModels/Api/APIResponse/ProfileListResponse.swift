//
//  ProfileListResponse.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import Foundation

public struct ProfileListResponse: Codable, Sendable, Equatable {
    public let invites: Invites
    public let likes: Likes

    public struct Invites: Codable, Equatable, Sendable {
        public let profiles: [Profile]
        public let totalPages: Int
        public let pendingInvitationsCount: Int

        private enum CodingKeys: String, CodingKey {
            case profiles, totalPages, pendingInvitationsCount = "pending_invitations_count"
        }

        public struct Profile: Codable, Equatable, Sendable {
            public let generalInformation: GeneralInformation
            public let approvedTime: Double
            public let disapprovedTime: Double
            public let photos: [Photo]
            public let userInterests: [UserInterest]
            public let work: Work?
            public let preferences: [Preference]
            public let instagramImages: String?
            public let lastSeenWindow: String
            public let isFacebookDataFetched: Bool
            public let icebreakers: String?
            public let story: String?
            public let meetup: String?
            public let verificationStatus: String
            public let hasActiveSubscription: Bool
            public let showConciergeBadge: Bool
            public let lat: Double
            public let lng: Double
            public let lastSeen: String?
            public let onlineCode: Int
            public let profileDataList: [ProfileData]

            private enum CodingKeys: String, CodingKey {
                case generalInformation = "general_information"
                case approvedTime = "approved_time"
                case disapprovedTime = "disapproved_time"
                case photos, userInterests = "user_interests", work, preferences
                case instagramImages = "instagram_images"
                case lastSeenWindow = "last_seen_window"
                case isFacebookDataFetched = "is_facebook_data_fetched"
                case icebreakers, story, meetup, verificationStatus = "verification_status"
                case hasActiveSubscription = "has_active_subscription"
                case showConciergeBadge = "show_concierge_badge"
                case lat, lng, lastSeen = "last_seen", onlineCode = "online_code"
                case profileDataList = "profile_data_list"
            }

            public struct GeneralInformation: Codable, Equatable, Sendable {
                public let dateOfBirth: String
                public let dateOfBirthV1: String
                public let location: Location
                public let drinkingV1: Drinking
                public let firstName: String
                public let gender: String
                public let maritalStatusV1: MaritalStatus
                public let refID: String
                public let smokingV1: Smoking
                public let sunSignV1: SunSign
                public let motherTongue: MotherTongue
                public let faith: Faith
                public let height: Int
                public let cast, kid, diet, politics, pet, settle, mbti: String?
                public let age: Int

                private enum CodingKeys: String, CodingKey {
                    case dateOfBirth = "date_of_birth"
                    case dateOfBirthV1 = "date_of_birth_v1"
                    case location, drinkingV1 = "drinking_v1", firstName = "first_name", gender
                    case maritalStatusV1 = "marital_status_v1"
                    case refID = "ref_id", smokingV1 = "smoking_v1"
                    case sunSignV1 = "sun_sign_v1", motherTongue = "mother_tongue"
                    case faith, height, cast, kid, diet, politics, pet, settle, mbti, age
                }

                public struct Location: Codable, Equatable, Sendable {
                    public let summary: String
                    public let full: String
                }

                public struct Drinking: Codable, Equatable, Sendable {
                    public let id: Int
                    public let name: String
                    public let nameAlias: String

                    private enum CodingKeys: String, CodingKey {
                        case id, name, nameAlias = "name_alias"
                    }
                }

                public struct MaritalStatus: Codable, Equatable, Sendable {
                    public let id: Int
                    public let name: String
                    public let preferenceOnly: Bool

                    private enum CodingKeys: String, CodingKey {
                        case id, name, preferenceOnly = "preference_only"
                    }
                }

                public struct Smoking: Codable, Equatable, Sendable {
                    public let id: Int
                    public let name: String
                    public let nameAlias: String

                    private enum CodingKeys: String, CodingKey {
                        case id, name, nameAlias = "name_alias"
                    }
                }

                public struct SunSign: Codable, Equatable, Sendable {
                    public let id: Int
                    public let name: String
                }

                public struct MotherTongue: Codable, Equatable, Sendable {
                    public let id: Int
                    public let name: String
                }

                public struct Faith: Codable, Equatable, Sendable {
                    public let id: Int
                    public let name: String
                }
            }

            public struct Photo: Codable, Equatable, Sendable {
                public let photo: String
                public let photoID: Int
                public let selected: Bool
                public let status: String?

                private enum CodingKeys: String, CodingKey {
                    case photo
                    case photoID = "photo_id"
                    case selected, status
                }
            }

            public struct UserInterest: Codable, Equatable, Sendable {}

            public struct Work: Codable, Equatable, Sendable {
                public let industryV1: Industry
                public let monthlyIncomeV1: String?
                public let experienceV1: Experience
                public let highestQualificationV1: Qualification
                public let fieldOfStudyV1: FieldOfStudy

                private enum CodingKeys: String, CodingKey {
                    case industryV1 = "industry_v1"
                    case monthlyIncomeV1 = "monthly_income_v1"
                    case experienceV1 = "experience_v1"
                    case highestQualificationV1 = "highest_qualification_v1"
                    case fieldOfStudyV1 = "field_of_study_v1"
                }

                public struct Industry: Codable, Equatable, Sendable {
                    public let id: Int
                    public let name: String
                    public let preferenceOnly: Bool

                    private enum CodingKeys: String, CodingKey {
                        case id, name, preferenceOnly = "preference_only"
                    }
                }

                public struct Experience: Codable, Equatable, Sendable {
                    public let id: Int
                    public let name: String
                    public let nameAlias: String

                    private enum CodingKeys: String, CodingKey {
                        case id, name, nameAlias = "name_alias"
                    }
                }

                public struct Qualification: Codable, Equatable, Sendable {
                    public let id: Int
                    public let name: String
                    public let preferenceOnly: Bool

                    private enum CodingKeys: String, CodingKey {
                        case id, name, preferenceOnly = "preference_only"
                    }
                }

                public struct FieldOfStudy: Codable, Equatable, Sendable {
                    public let id: Int
                    public let name: String
                }
            }

            public struct Preference: Codable, Equatable, Sendable {
                public let answerID: Int
                public let id: Int
                public let value: Int
                public let preferenceQuestion: PreferenceQuestion

                private enum CodingKeys: String, CodingKey {
                    case answerID = "answer_id"
                    case id, value, preferenceQuestion = "preference_question"
                }

                public struct PreferenceQuestion: Codable, Equatable, Sendable{
                    public let firstChoice: String
                    public let secondChoice: String

                    private enum CodingKeys: String, CodingKey {
                        case firstChoice = "first_choice"
                        case secondChoice = "second_choice"
                    }
                }
            }

            public struct ProfileData: Codable, Equatable, Sendable {
                public let question: String
                public let preferences: [PreferenceDetail]
                public let invitationType: String

                private enum CodingKeys: String, CodingKey {
                    case question, preferences
                    case invitationType = "invitation_type"
                }

                public struct PreferenceDetail: Codable, Equatable, Sendable {
                    public let answerID: Int
                    public let answer: String
                    public let firstChoice: String
                    public let secondChoice: String

                    private enum CodingKeys: String, CodingKey {
                        case answerID = "answer_id"
                        case answer, firstChoice = "first_choice"
                        case secondChoice = "second_choice"
                    }
                }
            }
        }
    }

    public struct Likes: Codable, Equatable, Sendable {
        public let profiles: [Profile]
        public let canSeeProfile: Bool
        public let likesReceivedCount: Int

        private enum CodingKeys: String, CodingKey {
            case profiles, canSeeProfile = "can_see_profile"
            case likesReceivedCount = "likes_received_count"
        }

        public struct Profile: Codable, Equatable, Sendable {
            public let firstName: String
            public let avatar: String

            private enum CodingKeys: String, CodingKey {
                case firstName = "first_name"
                case avatar
            }
        }
    }
}

public extension ProfileListResponse {
    // Mock instance
    static let mockProfileListResponse = ProfileListResponse(
        invites: ProfileListResponse.Invites(
            profiles: [
                ProfileListResponse.Invites.Profile(
                    generalInformation: ProfileListResponse.Invites.Profile.GeneralInformation(
                        dateOfBirth: "1993-02-11",
                        dateOfBirthV1: "11th February 1993",
                        location: ProfileListResponse.Invites.Profile.GeneralInformation.Location(summary: "IN, Rampur", full: "Rampur, Uttar Pradesh, IN"),
                        drinkingV1: ProfileListResponse.Invites.Profile.GeneralInformation.Drinking(id: 6, name: "Drinks Occasionally", nameAlias: "Drinks Occasionally"),
                        firstName: "Mayank",
                        gender: "Male",
                        maritalStatusV1: ProfileListResponse.Invites.Profile.GeneralInformation.MaritalStatus(id: 9, name: "Single", preferenceOnly: false),
                        refID: "1C76E221",
                        smokingV1: ProfileListResponse.Invites.Profile.GeneralInformation.Smoking(id: 2, name: "Non-Smoker", nameAlias: "Non-Smoker"),
                        sunSignV1: ProfileListResponse.Invites.Profile.GeneralInformation.SunSign(id: 2, name: "Aquarius"),
                        motherTongue: ProfileListResponse.Invites.Profile.GeneralInformation.MotherTongue(id: 2, name: "Hindi"),
                        faith: ProfileListResponse.Invites.Profile.GeneralInformation.Faith(id: 6, name: "Hindu"),
                        height: 62,
                        cast: nil,
                        kid: nil,
                        diet: nil,
                        politics: nil,
                        pet: nil,
                        settle: nil,
                        mbti: nil,
                        age: 29
                    ),
                    approvedTime: 1620885330.138944,
                    disapprovedTime: 1617951402.5616488,
                    photos: [
                        ProfileListResponse.Invites.Profile.Photo(photo: "https://testimages.aisle.co/f39552690128813a6e893b4f4cd725fc729869938.png", photoID: 130633, selected: true, status: "avatar"),
                        ProfileListResponse.Invites.Profile.Photo(photo: "https://testimages.aisle.co/2cb58925723382f002ba3f4d8f573011729866682.png", photoID: 130632, selected: false, status: nil)
                    ],
                    userInterests: [],
                    work: ProfileListResponse.Invites.Profile.Work(
                        industryV1: ProfileListResponse.Invites.Profile.Work.Industry(id: 13, name: "Information Technology", preferenceOnly: false),
                        monthlyIncomeV1: nil,
                        experienceV1: ProfileListResponse.Invites.Profile.Work.Experience(id: 5, name: "6 Years Experience", nameAlias: "6 Years Experience"),
                        highestQualificationV1: ProfileListResponse.Invites.Profile.Work.Qualification(id: 1, name: "Bachelors", preferenceOnly: false),
                        fieldOfStudyV1: ProfileListResponse.Invites.Profile.Work.FieldOfStudy(id: 2, name: "Engineering")
                    ),
                    preferences: [
                        ProfileListResponse.Invites.Profile.Preference(answerID: 32669, id: 10, value: 0, preferenceQuestion: ProfileListResponse.Invites.Profile.Preference.PreferenceQuestion(firstChoice: "Indoor", secondChoice: "Outdoor"))
                        // Add more preferences as needed
                    ],
                    instagramImages: nil,
                    lastSeenWindow: "2021-05-21T06:21:15.056Z",
                    isFacebookDataFetched: false,
                    icebreakers: nil,
                    story: nil,
                    meetup: nil,
                    verificationStatus: "verified",
                    hasActiveSubscription: false,
                    showConciergeBadge: false,
                    lat: 28.79,
                    lng: 79.02,
                    lastSeen: nil,
                    onlineCode: 0,
                    profileDataList: [
                        ProfileListResponse.Invites.Profile.ProfileData(
                            question: "Philosophy",
                            preferences: [
                                ProfileListResponse.Invites.Profile.ProfileData.PreferenceDetail(answerID: 32669, answer: "Indoor than Outdoor", firstChoice: "Indoor", secondChoice: "Outdoor")
                                // Add more preferences as needed
                            ],
                            invitationType: "preference"
                        )
                    ]
                )
            ],
            totalPages: 1,
            pendingInvitationsCount: 1
        ),
        likes: ProfileListResponse.Likes(
            profiles: [
                ProfileListResponse.Likes.Profile(firstName: "Ajith", avatar: "https://testimages.aisle.co/dd510d5260eeebcdc7d7fc752c598c39728894004.png"),
                ProfileListResponse.Likes.Profile(firstName: "Ishant", avatar: "https://testimages.aisle.co/58b125e52d319c0390fc2d68b7da2ba6729804903.png")
            ],
            canSeeProfile: false,
            likesReceivedCount: 2
        )
    )

}
