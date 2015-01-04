import Foundation

protocol FeedRequestDelegate {
    func feedUnansweredNotesRequestHandler(unansweredNotes : [Note])
    func feedNoteUserRquestHandler(user : User)
    func feedSpreadRequestHandler(code : Int)
    func feedDiscardRequestHandler(code : Int)
}
