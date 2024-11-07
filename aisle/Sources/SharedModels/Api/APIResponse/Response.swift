//
//  Response.swift
//  aisle
//
//  Created by Varun Adit on 11/5/24.
//

import Foundation

public struct Response: Codable {
    let invites: Invites
    let likes: Likes

    struct Invites: Codable {
        let profiles: [Profile]
        let totalPages: Int
        let pendingInvitationsCount: Int

        private enum CodingKeys: String, CodingKey {
            case profiles, totalPages, pendingInvitationsCount = "pending_invitations_count"
        }

        struct Profile: Codable {
            let generalInformation: GeneralInformation
            let approvedTime: Double
            let disapprovedTime: Double
            let photos: [Photo]
            let userInterests: [UserInterest]
            let work: Work?
            let preferences: [Preference]
            let instagramImages: String?
            let lastSeenWindow: String
            let isFacebookDataFetched: Bool
            let icebreakers: String?
            let story: String?
            let meetup: String?
            let verificationStatus: String
            let hasActiveSubscription: Bool
            let showConciergeBadge: Bool
            let lat: Double
            let lng: Double
            let lastSeen: String?
            let onlineCode: Int
            let profileDataList: [ProfileData]

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

            struct GeneralInformation: Codable {
                let dateOfBirth: String
                let dateOfBirthV1: String
                let location: Location
                let drinkingV1: Drinking
                let firstName: String
                let gender: String
                let maritalStatusV1: MaritalStatus
                let refID: String
                let smokingV1: Smoking
                let sunSignV1: SunSign
                let motherTongue: MotherTongue
                let faith: Faith
                let height: Int
                let cast, kid, diet, politics, pet, settle, mbti: String?
                let age: Int

                private enum CodingKeys: String, CodingKey {
                    case dateOfBirth = "date_of_birth"
                    case dateOfBirthV1 = "date_of_birth_v1"
                    case location, drinkingV1 = "drinking_v1", firstName = "first_name", gender
                    case maritalStatusV1 = "marital_status_v1"
                    case refID = "ref_id", smokingV1 = "smoking_v1"
                    case sunSignV1 = "sun_sign_v1", motherTongue = "mother_tongue"
                    case faith, height, cast, kid, diet, politics, pet, settle, mbti, age
                }

                struct Location: Codable {
                    let summary: String
                    let full: String
                }

                struct Drinking: Codable {
                    let id: Int
                    let name: String
                    let nameAlias: String

                    private enum CodingKeys: String, CodingKey {
                        case id, name, nameAlias = "name_alias"
                    }
                }

                struct MaritalStatus: Codable {
                    let id: Int
                    let name: String
                    let preferenceOnly: Bool

                    private enum CodingKeys: String, CodingKey {
                        case id, name, preferenceOnly = "preference_only"
                    }
                }

                struct Smoking: Codable {
                    let id: Int
                    let name: String
                    let nameAlias: String

                    private enum CodingKeys: String, CodingKey {
                        case id, name, nameAlias = "name_alias"
                    }
                }

                struct SunSign: Codable {
                    let id: Int
                    let name: String
                }

                struct MotherTongue: Codable {
                    let id: Int
                    let name: String
                }

                struct Faith: Codable {
                    let id: Int
                    let name: String
                }
            }

            struct Photo: Codable {
                let photo: String
                let photoID: Int
                let selected: Bool
                let status: String?

                private enum CodingKeys: String, CodingKey {
                    case photo
                    case photoID = "photo_id"
                    case selected, status
                }
            }

            struct UserInterest: Codable {}

            struct Work: Codable {
                let industryV1: Industry
                let monthlyIncomeV1: String?
                let experienceV1: Experience
                let highestQualificationV1: Qualification
                let fieldOfStudyV1: FieldOfStudy

                private enum CodingKeys: String, CodingKey {
                    case industryV1 = "industry_v1"
                    case monthlyIncomeV1 = "monthly_income_v1"
                    case experienceV1 = "experience_v1"
                    case highestQualificationV1 = "highest_qualification_v1"
                    case fieldOfStudyV1 = "field_of_study_v1"
                }

                struct Industry: Codable {
                    let id: Int
                    let name: String
                    let preferenceOnly: Bool

                    private enum CodingKeys: String, CodingKey {
                        case id, name, preferenceOnly = "preference_only"
                    }
                }

                struct Experience: Codable {
                    let id: Int
                    let name: String
                    let nameAlias: String

                    private enum CodingKeys: String, CodingKey {
                        case id, name, nameAlias = "name_alias"
                    }
                }

                struct Qualification: Codable {
                    let id: Int
                    let name: String
                    let preferenceOnly: Bool

                    private enum CodingKeys: String, CodingKey {
                        case id, name, preferenceOnly = "preference_only"
                    }
                }

                struct FieldOfStudy: Codable {
                    let id: Int
                    let name: String
                }
            }

            struct Preference: Codable {
                let answerID: Int
                let id: Int
                let value: Int
                let preferenceQuestion: PreferenceQuestion

                private enum CodingKeys: String, CodingKey {
                    case answerID = "answer_id"
                    case id, value, preferenceQuestion = "preference_question"
                }

                struct PreferenceQuestion: Codable {
                    let firstChoice: String
                    let secondChoice: String

                    private enum CodingKeys: String, CodingKey {
                        case firstChoice = "first_choice"
                        case secondChoice = "second_choice"
                    }
                }
            }

            struct ProfileData: Codable {
                let question: String
                let preferences: [PreferenceDetail]
                let invitationType: String

                private enum CodingKeys: String, CodingKey {
                    case question, preferences
                    case invitationType = "invitation_type"
                }

                struct PreferenceDetail: Codable {
                    let answerID: Int
                    let answer: String
                    let firstChoice: String
                    let secondChoice: String

                    private enum CodingKeys: String, CodingKey {
                        case answerID = "answer_id"
                        case answer, firstChoice = "first_choice"
                        case secondChoice = "second_choice"
                    }
                }
            }
        }
    }

    struct Likes: Codable {
        let profiles: [Profile]
        let canSeeProfile: Bool
        let likesReceivedCount: Int

        private enum CodingKeys: String, CodingKey {
            case profiles, canSeeProfile = "can_see_profile"
            case likesReceivedCount = "likes_received_count"
        }

        struct Profile: Codable {
            let firstName: String
            let avatar: String

            private enum CodingKeys: String, CodingKey {
                case firstName = "first_name"
                case avatar
            }
        }
    }
}
