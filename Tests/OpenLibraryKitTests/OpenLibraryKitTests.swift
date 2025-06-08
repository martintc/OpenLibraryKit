import Testing
@testable import OpenLibraryKit

@Test func searchByTitle() async throws {
    do {
        OpenLibraryClient.shared.userAgent = "test/1.0 (example@example.com)"
        let response = try await OpenLibraryClient.shared.searchByTitle("lord of the rings")
        print(response)
        #expect(response.docs.count > 0)
    } catch {
        print("Error: \(error)")
    }
}

@Test func searchByAuthor() async throws {
    do {
        OpenLibraryClient.shared.userAgent = "test/1.0 (example@example.com)"
        let response = try await OpenLibraryClient.shared.searchByAuthor("J.R.R. Tolkien")
        print(response)
        #expect(response.docs.count > 0)
    } catch {
        print("Error: \(error)")
    }
}

@Test func isbnSearch() async throws {
    do {
        OpenLibraryClient.shared.userAgent = "test/1.0 (example@example.com)"
        let isbn = "9780593650868"
        let response = try await OpenLibraryClient.shared.isbnSearch(isbn: isbn)
        print(response)
        #expect(response.records.count > 0)
    } catch {
        print("Error: \(error)")
    }
}

@Test func getCoverUrl() async throws {
    let url = OpenLibraryClient.shared.getCoverUrl(isbn: "0385472579", size: Size.small)
    #expect(url == "https://covers.openlibrary.org/b/isbn/0385472579-S.jpg")
}
