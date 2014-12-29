import Foundation

protocol LoginRequestDelegate{
    func loginRequestHandler(code : Int, id : String)
}