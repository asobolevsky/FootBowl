//
//  FootballAPITests.swift
//  FootBowlTests
//
//  Created by Aleksei Sobolevskii on 2024-06-13.
//

import Testing
@testable import FootBowl

struct FootballAPITests {
    @Test
    func leaguesEndpoint() async throws {
        let leaguesNoSearch = FootballAPI.leagues()
        #expect(leaguesNoSearch.path == "/v3/leagues")
        #expect(leaguesNoSearch.method == .GET)
        #expect(leaguesNoSearch.headers == nil)
        #expect(leaguesNoSearch.parameters == nil)

        let leaguesWithSearch = FootballAPI.leagues(search: "foo")
        #expect(leaguesWithSearch.parameters == ["search": "foo"])
    }
}
