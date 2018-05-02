//
//  DemoServer.swift
//  BrokenPipeDemoDesktop
//
//  Created by Josh Avant on 5/2/18.
//  Copyright © 2018 Josh Avant. All rights reserved.
//

import Foundation
import Telegraph

class DemoServer {
    private let server: Server
    private static let port: UInt16 = 9000
    
    required init() {
        self.server = Server()
        
        self.server.webSocketConfig.pingInterval = 10
        self.server.webSocketDelegate = self
    }
    
    func run() throws {
        try server.start(onInterface: "localhost", port: DemoServer.port)
        
        self.serverLog("Server is running")
    }
    
    func stop(immediately: Bool = false) {
        self.server.stop(immediately: immediately)
    }
}

extension DemoServer: ServerWebSocketDelegate {
    func server(_ server: Server, webSocketDidConnect webSocket: WebSocket, handshake: HTTPRequest) {
        let name = handshake.headers["X-Name"] ?? "Stranger"
        self.serverLog("WebSocket connected (\(name))")
    }
    
    func server(_ server: Server, webSocketDidDisconnect webSocket: WebSocket, error: Error?) {
        if let error = error {
            self.serverLog("WebSocket disconnected, error: \(error)")
        } else {
            self.serverLog("WebSocket disconnected")
        }
    }
    
    func server(_ server: Server, webSocket: WebSocket, didReceiveMessage message: WebSocketMessage) {
        guard message.opcode != .pong else { return } // ignore ping/pongs
        
        self.serverLog("WebSocket received message: \(message)")
    }
    
    func server(_ server: Server, webSocket: WebSocket, didSendMessage message: WebSocketMessage) {
        guard message.opcode != .ping else { return } // ignore ping/pongs
        
        self.serverLog("WebSocket sent message: \(message)")
    }
    
    func serverDidDisconnect(_ server: Server) {
        self.serverLog("Server disconnected")
    }
}

// Logging Helpers
extension DemoServer {
    private func serverLog(_ message: String) {
        print("[SERVER] \(message)")
    }
}
