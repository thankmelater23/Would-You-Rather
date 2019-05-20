//
//  AdExtensions.swift
//  Would You Rather
//
//  Created by Andre on 5/1/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import Foundation
import GoogleMobileAds

// MARK: - MainViewController Ad functions
/// MainViewController GADBannerViewDelegate Extension
extension MainViewController: GADBannerViewDelegate {
    func animateAdStarting() {
        bannerView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.bannerView.alpha = 1
        })
    }

    /// Initializes Ad Banner with view
    func adBannerInit() {
        //    if !Settings.adPurchased {

        log.info("Ad was not purchased")

        // Set test Device
        // BEFORERELEASE: - Disable this before release so users can acutally get ads
        //        let request = GADRequest()
        //        request.testDevices = [ kGADSimulatorID,                       // All simulators
        //        "2077ef9a63d2b398840261c8221a0c9b" ];  // Sample device ID
        //        Sets size for view vontroller to insert in view.

        // Smart Banner
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)

        //    bannerView.adSize = kGADAdSizeSmartBannerPortrait

        // Sets ad type
        bannerView.adUnitID = PrivateKeys.google_Ad_ID_Key_MainMenuView

        // Sets delagate for banner
        bannerView.delegate = self

        bannerView.rootViewController = self
        ////
        //        // Loads Banner
        bannerView.load(GADRequest())

        bannerView.isHidden = false
        //    } else {
        //      log.info("Ad was purchased, removing banner")
        //      adBannerPlaceHolder.removeFromSuperview()
        //    }
    }

    /// Adds banner to view and set constraints
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [
                NSLayoutConstraint(item: bannerView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: bottomLayoutGuide,
                                   attribute: .top,
                                   multiplier: 1,
                                   constant: 0),
                NSLayoutConstraint(item: bannerView,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: view,
                                   attribute: .centerX,
                                   multiplier: 1,
                                   constant: 0),
        ])
    }

    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        log.verbose(#function)
        //    defer { log.info(Settings.adPurchased) }

        // Add banner to view

        log.info("Ad was added to view")
        addBannerViewToView(bannerView)

        animateAdStarting()
    }

    /// Tells the delegate an ad request failed.
    func adView(_: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        log.warning("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_: GADBannerView) {
        log.verbose(#function)
    }

    /// Tells the delegate that the full screen view will be dismissed.
    func adViewWillDismissScreen(_: GADBannerView) {
        log.verbose(#function)
    }

    /// Tells the delegate that the full screen view has been dismissed.
    func adViewDidDismissScreen(_: GADBannerView) {
        log.verbose(#function)
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_: GADBannerView) {
        log.warning(#function)
    }
}

// MARK: - GameViewController Ad Extension
/// GameViewController GADBannerViewDelegate Extension
extension GameViewController: GADBannerViewDelegate {
    func animateAdStarting() {
        bannerView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.bannerView.alpha = 1
        })
    }

    /// Initializes Ad Banner with view
    func adBannerInit() {
        //    if !Settings.adPurchased {

        log.info("Ad was not purchased")

        // Set test Device
        // BEFORERELEASE: - Disable this before release so users can acutally get ads
        //        let request = GADRequest()
        //        request.testDevices = [ kGADSimulatorID,                       // All simulators
        //        "2077ef9a63d2b398840261c8221a0c9b" ];  // Sample device ID
        //        Sets size for view vontroller to insert in view.

        // Smart Banner
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)

        //    bannerView.adSize = kGADAdSizeSmartBannerPortrait

        // Sets ad type
        bannerView.adUnitID = PrivateKeys.google_Ad_ID_Key_GameView

        // Sets delagate for banner
        bannerView.delegate = self

        bannerView.rootViewController = self
        ////
        //        // Loads Banner
        bannerView.load(GADRequest())

        bannerView.isHidden = false
        //    } else {
        //      log.info("Ad was purchased, removing banner")
        //      adBannerPlaceHolder.removeFromSuperview()
        //    }
    }

    /// Adds banner to view and set constraints
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [
                NSLayoutConstraint(item: bannerView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: bottomLayoutGuide,
                                   attribute: .top,
                                   multiplier: 1,
                                   constant: 0),
                NSLayoutConstraint(item: bannerView,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: view,
                                   attribute: .centerX,
                                   multiplier: 1,
                                   constant: 0),
        ])
    }

    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        log.verbose(#function)
        //    defer { log.info(Settings.adPurchased) }

        // Add banner to view

        log.info("Ad was added to view")
        addBannerViewToView(bannerView)

        animateAdStarting()
    }

    /// Tells the delegate an ad request failed.
    func adView(_: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        log.warning("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_: GADBannerView) {
        log.verbose(#function)
    }

    /// Tells the delegate that the full screen view will be dismissed.
    func adViewWillDismissScreen(_: GADBannerView) {
        log.verbose(#function)
    }

    /// Tells the delegate that the full screen view has been dismissed.
    func adViewDidDismissScreen(_: GADBannerView) {
        log.verbose(#function)
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_: GADBannerView) {
        log.warning(#function)
    }
}

// MARK: - HistoryTableViewController Ad Extension
/// HistoryTableViewController GADBannerViewDelegate Extension
extension HistoryTableViewController: GADBannerViewDelegate {
    func animateAdStarting() {
        bannerView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.bannerView.alpha = 1
        })
    }

    /// Initializes Ad Banner with view
    func adBannerInit() {
        //    if !Settings.adPurchased {

        log.info("Ad was not purchased")

        // Set test Device
        // BEFORERELEASE: - Disable this before release so users can acutally get ads
        //        let request = GADRequest()
        //        request.testDevices = [ kGADSimulatorID,                       // All simulators
        //        "2077ef9a63d2b398840261c8221a0c9b" ];  // Sample device ID
        //        Sets size for view vontroller to insert in view.

        // Smart Banner
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)

        //    bannerView.adSize = kGADAdSizeSmartBannerPortrait

        // Sets ad type
        bannerView.adUnitID = PrivateKeys.google_Ad_ID_Key_HistoryTable

        // Sets delagate for banner
        bannerView.delegate = self

        bannerView.rootViewController = self
        ////
        //        // Loads Banner
        bannerView.load(GADRequest())

        bannerView.isHidden = false
        //    } else {
        //      log.info("Ad was purchased, removing banner")
        //      adBannerPlaceHolder.removeFromSuperview()
        //    }
    }

    /// Adds banner to view and set constraints
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [
                NSLayoutConstraint(item: bannerView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: bottomLayoutGuide,
                                   attribute: .top,
                                   multiplier: 1,
                                   constant: 0),
                NSLayoutConstraint(item: bannerView,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: view,
                                   attribute: .centerX,
                                   multiplier: 1,
                                   constant: 0),
        ])
    }

    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        log.verbose(#function)
        //    defer { log.info(Settings.adPurchased) }

        // Add banner to view

        log.info("Ad was added to view")
        addBannerViewToView(bannerView)

        animateAdStarting()
    }

    /// Tells the delegate an ad request failed.
    func adView(_: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        log.warning("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_: GADBannerView) {
        log.verbose(#function)
    }

    /// Tells the delegate that the full screen view will be dismissed.
    func adViewWillDismissScreen(_: GADBannerView) {
        log.verbose(#function)
    }

    /// Tells the delegate that the full screen view has been dismissed.
    func adViewDidDismissScreen(_: GADBannerView) {
        log.verbose(#function)
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_: GADBannerView) {
        log.warning(#function)
    }
}
