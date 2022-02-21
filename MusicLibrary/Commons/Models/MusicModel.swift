// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let musicModel = try? newJSONDecoder().decode(MusicModel.self, from: jsonData)

import Foundation

// MARK: - MusicModel
struct MusicModel: Codable {
    let message: Message?
}

// MARK: - Message
struct Message: Codable {
    let header: Header?
    let body: Body?
}

// MARK: - Body
struct Body: Codable {
    let trackList: [TrackList]?
    let artistList: [ArtistList]?

    enum CodingKeys: String, CodingKey {
        case trackList = "track_list"
        case artistList = "artist_list"
    }
}

// MARK: - TrackList
struct TrackList: Codable {
    var track: Track?
}

struct ArtistList: Codable {
    let artist: Artist?
}

// MARK: - Track
struct Track: Codable {
    let trackID: Int?
    let trackName: String?
    let trackNameTranslationList: [TrackNameTranslationList]?
    let trackRating, commontrackID, instrumental, explicit: Int?
    let hasLyrics, hasSubtitles, hasRichsync, numFavourite: Int?
    var albumID: Int = 0
    let albumName: String?
    let artistID: Int?
    let artistName: String?
    let trackShareURL, trackEditURL: String?
    let restricted: Int?
    let updatedTime: String?
    let primaryGenres: PrimaryGenres?

    enum CodingKeys: String, CodingKey {
        case trackID = "track_id"
        case trackName = "track_name"
        case trackNameTranslationList = "track_name_translation_list"
        case trackRating = "track_rating"
        case commontrackID = "commontrack_id"
        case instrumental, explicit
        case hasLyrics = "has_lyrics"
        case hasSubtitles = "has_subtitles"
        case hasRichsync = "has_richsync"
        case numFavourite = "num_favourite"
        case albumID = "album_id"
        case albumName = "album_name"
        case artistID = "artist_id"
        case artistName = "artist_name"
        case trackShareURL = "track_share_url"
        case trackEditURL = "track_edit_url"
        case restricted
        case updatedTime = "updated_time"
        case primaryGenres = "primary_genres"
    }
}

// MARK: - Artist
struct Artist: Codable {
    let artistID: Int?
    let artistName: String?
    let artistNameTranslationList: [ArtistNameTranslationList]?
    let artistComment, artistCountry: String?
    let artistAliasList: [ArtistAliasList]?
    let artistRating: Int?
    let artistTwitterURL: String?
    let artistCredits: Body?
    let restricted: Int?
    let updatedTime: String?
    let beginDateYear, beginDate, endDateYear, endDate: String?

    enum CodingKeys: String, CodingKey {
        case artistID = "artist_id"
        case artistName = "artist_name"
        case artistNameTranslationList = "artist_name_translation_list"
        case artistComment = "artist_comment"
        case artistCountry = "artist_country"
        case artistAliasList = "artist_alias_list"
        case artistRating = "artist_rating"
        case artistTwitterURL = "artist_twitter_url"
        case artistCredits = "artist_credits"
        case restricted
        case updatedTime = "updated_time"
        case beginDateYear = "begin_date_year"
        case beginDate = "begin_date"
        case endDateYear = "end_date_year"
        case endDate = "end_date"
    }
}

// MARK: - PrimaryGenres
struct PrimaryGenres: Codable {
    let musicGenreList: [MusicGenreList]?

    enum CodingKeys: String, CodingKey {
        case musicGenreList = "music_genre_list"
    }
}

// MARK: - ArtistAliasList
struct ArtistAliasList: Codable {
    let artistAlias: String?

    enum CodingKeys: String, CodingKey {
        case artistAlias = "artist_alias"
    }
}

// MARK: - ArtistNameTranslationList
struct ArtistNameTranslationList: Codable {
    let artistNameTranslation: ArtistNameTranslation?

    enum CodingKeys: String, CodingKey {
        case artistNameTranslation = "artist_name_translation"
    }
}

// MARK: - ArtistNameTranslation
struct ArtistNameTranslation: Codable {
    let language, translation: String?
}

// MARK: - Header
struct Header: Codable {
    let statusCode: Int?
    let executeTime: Double?
    let available: Int?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case executeTime = "execute_time"
        case available
    }
}


// MARK: - MusicGenreList
struct MusicGenreList: Codable {
    let musicGenre: MusicGenre?

    enum CodingKeys: String, CodingKey {
        case musicGenre = "music_genre"
    }
}

// MARK: - MusicGenre
struct MusicGenre: Codable {
    let musicGenreID, musicGenreParentID: Int?
    let musicGenreName, musicGenreNameExtended, musicGenreVanity: String?

    enum CodingKeys: String, CodingKey {
        case musicGenreID = "music_genre_id"
        case musicGenreParentID = "music_genre_parent_id"
        case musicGenreName = "music_genre_name"
        case musicGenreNameExtended = "music_genre_name_extended"
        case musicGenreVanity = "music_genre_vanity"
    }
}

// MARK: - TrackNameTranslationList
struct TrackNameTranslationList: Codable {
    let trackNameTranslation: TrackNameTranslation?

    enum CodingKeys: String, CodingKey {
        case trackNameTranslation = "track_name_translation"
    }
}

// MARK: - TrackNameTranslation
struct TrackNameTranslation: Codable {
    let language, translation: String?
}

//// MARK: - Header
//struct Header: Codable {
//    let statusCode: Int?
//    let executeTime: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case statusCode = "status_code"
//        case executeTime = "execute_time"
//    }
//}
