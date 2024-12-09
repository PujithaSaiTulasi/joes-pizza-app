import Foundation
import UIKit
import FirebaseFunctions
import Stripe
import StripePaymentSheet

func payWithStripe(clientSecret: String) {
    // Setup your Stripe configuration
    StripeAPI.defaultPublishableKey = "pk_test_51QTAweCFUxO8Rf5EXbPqNKrES58zvd70S1ZRulW35Cmnvl8rcU5tmnAJ328iIXWEggYxRVB4dt2Jhd3rTC1ocoAM00sFKnhQtP"
    
    // Initialize card parameters
    let cardParams = STPPaymentMethodCardParams()
    cardParams.number = "4242424242424242" // Replace with actual card number
    cardParams.expMonth = NSNumber(value: 12) // Replace with actual expiry month
    cardParams.expYear = NSNumber(value: 2024) // Replace with actual expiry year
    cardParams.cvc = "123" // Replace with actual CVC
    
    // Use Stripe's PaymentMethodContext to handle payment details
    let paymentMethodParams = STPPaymentMethodParams(card: cardParams, billingDetails: nil, metadata: nil)
    let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
    paymentIntentParams.paymentMethodParams = paymentMethodParams
    
    // Use the shared instance of STPAPIClient
    STPAPIClient.shared.confirmPaymentIntent(with: paymentIntentParams) { (paymentIntent, error) in
        if let error = error {
            print("Error confirming payment: \(error.localizedDescription)")
            return
        }
        
        if paymentIntent?.status == .succeeded {
            print("Payment successful!")
            // Handle post-payment actions (e.g., navigate to confirmation page)
            showPaymentSuccess()
        } else {
            print("Payment not completed: \(String(describing: paymentIntent?.status))")
        }
    }
    
    func showPaymentSuccess() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("Unable to find the root view controller.")
            return
        }
        
        let alert = UIAlertController(title: "Success", message: "Your payment was successful!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            // Optionally navigate to a confirmation screen or reset UI
            print("Navigating to confirmation...")
        })
        
        DispatchQueue.main.async {
            rootViewController.present(alert, animated: true)
        }
    }
}

