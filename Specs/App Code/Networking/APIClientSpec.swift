import Quick
import Nimble
@testable import Cuadrado

class APIClientSpec: QuickSpec {
    override func spec() {
        describe("APIClient") {
            var subject: APIClient!
            
            var fakeURLSession: FakeURLSession!

            beforeEach {
                fakeURLSession = FakeURLSession(configuration: .default)
                
                subject = APIClient(baseURL: URL(string: "https://ryan.codes")!, urlSession: fakeURLSession)
            }
            
            it("is built with default url session configuration") {
                expect(fakeURLSession.capturedInitConfiguration).to(equal(.default))
            }
            
            describe("#get(endpoint:completionHandler:)") {
                var capturedResult: Result<Any, APIClientError>!
                
                describe("errors") {
                    describe("on invalid HTTPURLResponse") {
                        beforeEach {
                            subject.get(endpoint: "/not-a-real-endpoint") { result in
                                capturedResult = result
                            }
                            
                            let fakeData = Data("fakeData".utf8)
                            
                            fakeURLSession.capturedCompletionHandler?(fakeData, nil, nil)
                        }
                        
                        it("returns a result that has an sessionError") {
                            do {
                                _ = try capturedResult.get()
                            } catch {
                                expect(error).to(matchError(APIClientError.sessionError))
                            }
                        }
                    }
                    
                    describe("on nil data") {
                        beforeEach {
                            subject.get(endpoint: "/not-a-real-endpoint") { result in
                                capturedResult = result
                            }
                            
                            let fakeHTTPURLResponse = HTTPURLResponse()
                            
                            fakeURLSession.capturedCompletionHandler?(nil, fakeHTTPURLResponse, nil)
                        }
                        
                        it("returns a result that has an sessionError") {
                            do {
                                _ = try capturedResult.get()
                            } catch {
                                expect(error).to(matchError(APIClientError.sessionError))
                            }
                        }
                    }
                    
                    describe("on session error") {
                        beforeEach {
                            subject.get(endpoint: "/not-a-real-endpoint") { result in
                                capturedResult = result
                            }
                            
                            let fakeData = Data("fakeData".utf8)
                            let fakeHTTPURLResponse = HTTPURLResponse()
                            
                            fakeURLSession.capturedCompletionHandler?(fakeData, fakeHTTPURLResponse, FakeURLSessionError.whocares)
                        }
                        
                        it("returns a result that has an sessionError") {
                            do {
                                _ = try capturedResult.get()
                            } catch {
                                expect(error).to(matchError(APIClientError.sessionError))
                            }
                        }
                    }
                    
                    describe("on a non-200 status code") {
                        beforeEach {
                            subject.get(endpoint: "/not-a-real-endpoint") { result in
                                capturedResult = result
                            }
                            
                            let fakeData = Data("fakeData".utf8)
                            let fakeHTTPURLResponse = HTTPURLResponse(url: URL(string: "https://whocares.com")!, statusCode: 999, httpVersion: "1.1", headerFields: nil)
                            
                            fakeURLSession.capturedCompletionHandler?(fakeData, fakeHTTPURLResponse, nil)
                        }
                        
                        it("returns a result that has an statusErrorCode") {
                            do {
                                _ = try capturedResult.get()
                            } catch {
                                expect(error).to(matchError(APIClientError.statusCodeError))
                            }
                        }
                    }
                    
                    describe("on a json response error") {
                        beforeEach {
                            subject.get(endpoint: "/not-a-real-endpoint") { result in
                                capturedResult = result
                            }
                            
                            let fakeData = Data("fakeData".utf8)
                            let fakeHTTPURLResponse = HTTPURLResponse(url: URL(string: "https://whocares.com")!, statusCode: 999, httpVersion: "1.1", headerFields: nil)
                            
                            fakeURLSession.capturedCompletionHandler?(fakeData, fakeHTTPURLResponse, nil)
                        }
                        
                        it("returns a result that has an statusErrorCode") {
                            do {
                                _ = try capturedResult.get()
                            } catch {
                                expect(error).to(matchError(APIClientError.statusCodeError))
                            }
                        }
                    }
                }
                
                describe("on success") {
                    beforeEach {
                        subject.get(endpoint: "/not-a-real-endpoint") { result in
                            capturedResult = result
                        }
                        
                        let fakeData = createData(dict: ["yay": "sir"])
                        let fakeHTTPURLResponse = HTTPURLResponse(url: URL(string: "https://whocares.com")!, statusCode: 200, httpVersion: "1.1", headerFields: nil)
                        
                        fakeURLSession.capturedCompletionHandler?(fakeData, fakeHTTPURLResponse, nil)
                    }
                    
                    it("returns a result with a json response (dictionary)") {
                        do {
                            let jsonResponse = try capturedResult.get() as! [String: String]
                            
                            expect(jsonResponse).to(equal(["yay": "sir"]))
                        } catch {
                            XCTFail("Your jsonResponse success case is failing")
                        }
                    }
                }
            }
        }
    }
}

