import Foundation

protocol FeedRequestDelegate {
    func feedUnansweredNotesRequestHandler(unansweredNotes : [Note])
    func feedNoteUserRquestHandler(user : User)
}
