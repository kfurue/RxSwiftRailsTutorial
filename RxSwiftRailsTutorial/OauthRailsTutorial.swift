//
//  OauthRailsTutorial.swift
//  RxSwiftRailsTutorial
//
//  Created by Kazuhiro Furue on 2018/05/16.
//  Copyright © 2018年 Kazuhiro Furue. All rights reserved.
//

import Foundation
import UIKit
import KeychainAccess
import OAuthSwift

final class OauthRailsTutorial {

    static let callbackURL = "sample-app://oauth-callback"
    static let keychainService = "kfurue.RxSwiftRailsTutorial-token"
    static let oauthTokenKey = "oauthToken"
    static let oauthRefreshTokenKey = "oauthRefreshToken"

    var oauthSwift: OAuth2Swift

    init() {
        oauthSwift = OAuth2Swift(
            consumerKey: "3d0d70ef4ab7c7e2b783a7248116c061c0b136be86e359c20578e07d7b804aec",
            consumerSecret: "05b2b029398108a428db189dc5006a20c2c0cb0357e15b94a29541a6f8c86441",
            authorizeUrl: "https://fierce-wave-40771.herokuapp.com/oauth/authorize",
            accessTokenUrl: "https://fierce-wave-40771.herokuapp.com/oauth/token",
            responseType: "code"
        )

    }

    /// Execute handler with valid token.
    /// Token will be gained as following
    /// 1. Read from Keychain if it stored
    /// 2. Request token from RailsTutorial web site
    /// and store it into Keychain
    ///
    /// - Important
    /// Add following lines into your AppDelegate.
    ///
    /// ```
    ///     func application(_ app: UIApplication,
    ///    open url: URL,
    ///    options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
    ///    if url.host == "oauth-callback" {
    ///    OAuthSwift.handle(url: url)
    ///    }
    ///    return true
    ///    }
    /// ```
    ///
    /// - Parameter completion: executed with valid Keychain
    func token(completion: ((String?, Error?) -> Void)?) {
        let keychain = Keychain(service: OauthRailsTutorial.keychainService)

        let oauthToken = keychain[OauthRailsTutorial.oauthTokenKey]

        if oauthToken == nil {
            oauthSwift.authorize(
                withCallbackURL: URL(string: OauthRailsTutorial.callbackURL)!,
                scope: "", state: "hoge",
                success: { credential, _, _ in
                    self.storeCredential(into: keychain,
                                         credential: credential)
                    completion?(credential.oauthToken, nil)
            },
                failure: { error in
                    print(error.localizedDescription)
            }
            )
        } else {
            let path = "/api/v1/feed"
            let URLString = SampleAppClientAPI.basePath + path

            oauthSwift.client.credential.oauthToken = oauthToken!

            _ = oauthSwift.client.get(
                URLString,
                success: { (_) in
                    completion?(oauthToken, nil)
            }, failure: { (error) in
                self.refresh(completion: { (token, error) in
                    completion?(token, error)
                })
            })
        }
    }

    private func refresh(completion: ((String?, Error?) -> Void)?) {
        let keychain = Keychain(service: OauthRailsTutorial.keychainService)
        guard let refreshToken = keychain[OauthRailsTutorial.oauthRefreshTokenKey] else {
            completion?(nil, nil)
            return
        }
        oauthSwift.renewAccessToken(
            withRefreshToken: refreshToken,
            success: { [unowned self] (credential, _, _) in
                self.storeCredential(into: keychain,
                                     credential: credential)
                completion?(credential.oauthToken, nil)
            }, failure: { (error) in
                print(error)
                completion?(nil, error)
        })
    }

    private func storeCredential(into: Keychain,
                                 credential: OAuthSwiftCredential) {
        into[OauthRailsTutorial.oauthTokenKey] = credential.oauthToken
        into[OauthRailsTutorial.oauthRefreshTokenKey] = credential.oauthRefreshToken
    }
}
