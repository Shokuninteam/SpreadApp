import Foundation

protocol ProfilRequestDelegate {
    func profilUserRequestHandler(user : User)
    func profilHistoryRequestHandler(notes: [Note])
}
