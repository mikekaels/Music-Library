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

    enum CodingKeys: String, CodingKey {
        case trackList = "track_list"
    }
}

// MARK: - TrackList
struct TrackList: Codable {
    var track: Track?
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

// MARK: - PrimaryGenres
struct PrimaryGenres: Codable {
    let musicGenreList: [MusicGenreList]?

    enum CodingKeys: String, CodingKey {
        case musicGenreList = "music_genre_list"
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

// MARK: - Header
struct Header: Codable {
    let statusCode: Int?
    let executeTime: Double?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case executeTime = "execute_time"
    }
}
