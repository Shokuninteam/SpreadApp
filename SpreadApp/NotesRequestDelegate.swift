import Foundation

protocol NotesRequestDelegate {
    func notesTopRequestHandler(topNotes : [Note])
    func notesFavsRequestHandler(favNotes : [Note])
    func notesSpreadedRequestHandler(spreadedNotes : [Note])
}
