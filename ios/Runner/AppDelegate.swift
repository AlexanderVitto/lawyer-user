import UIKit
import Flutter
import MidtransKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, FlutterStreamHandler, MidtransUIPaymentViewControllerDelegate {
    private var flutterVC: FlutterViewController?
    private var paymentListener: FlutterEventSink?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    MidtransConfig.shared().setClientKey("SB-Mid-client-gQqFLZ_iSOw7I5md", environment: .sandbox, merchantServerURL: "https://tengkulak.herokuapp.com/index.php/")
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    self.flutterVC = controller
    
    let paymentGateway = FlutterMethodChannel(name: "com.example.local_psykay.payment_gateway",
                                                  binaryMessenger: controller.binaryMessenger)
    let paymentStatus = FlutterEventChannel(name: "com.example.local_psykay.payment_gateway/status", binaryMessenger: controller.binaryMessenger)
        
    paymentGateway.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult)-> Void in
        switch call.method{
        case "showMidtrans":
            self?.midtrans(call: call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    })
    
    paymentStatus.setStreamHandler(self)
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func midtrans(call: FlutterMethodCall, result: @escaping FlutterResult){
        if let args = call.arguments as? Dictionary<String, Any>,
           let name = args["name"] as? String,
           let price = args["price"] as? Int,
           let qty = args["quantity"] as? Int{
            
            let itemDetail = MidtransItemDetail.init(itemID: "1" ,name: name, price: NSNumber(integerLiteral: price), quantity: NSNumber(integerLiteral: qty))
            
            let shippingAddress = MidtransAddress.init(firstName: "Budi", lastName: "Utomo", phone: "08123456789", address: "Jalan Andalas Gang Sebelah No. 1", city: "Jakarta", postalCode: "10220", countryCode: nil)
            
            let billingAddress = MidtransAddress.init(firstName: "Budi", lastName: "Utomo", phone: "08123456789", address: "Jalan Andalas Gang Sebelah No. 1", city: "Jakarta", postalCode: "10220", countryCode: nil)
            
            
            let customerDetail = MidtransCustomerDetails.init(firstName: "Budi", lastName: "Utomo", email: "budi@utomo.com", phone: "08123456789", shippingAddress: shippingAddress, billingAddress: billingAddress)
            
            let grossAmmount = price * qty
            let orderID = NSDate().timeIntervalSince1970 * 1000
            
            let transactionDetail = MidtransTransactionDetails.init(orderID:NSDecimalNumber(value: orderID).stringValue, andGrossAmount: NSNumber(integerLiteral: grossAmmount))
            
            MidtransMerchantClient.shared().requestTransactionToken(with: transactionDetail!, itemDetails: [itemDetail!], customerDetails:  customerDetail) { (response, error) in
                if let token = response {
                    let vc = MidtransUIPaymentViewController(token: token)
                    vc?.paymentDelegate = self
                    self.flutterVC?.present(vc!, animated: true, completion: nil)
                    
                    result("Sukses")
                }else{
                    result("Error requesting token \(error?.localizedDescription ?? "fdf")")
                }
            }
            
        }else{
            result(FlutterError.init(code: "bad args", message: nil, details: nil))
        }
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.paymentListener = events
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        paymentListener = nil
        
        return nil
    }
    
    func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentPending result: MidtransTransactionResult!) {
        let data:[String: Any] = ["transaction_id": result.transactionId!, "status": result.transactionStatus!]
        
        guard let paymentListener = paymentListener else {
            return
        }
        paymentListener(data)
        
    }
    
    func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentDeny result: MidtransTransactionResult!) {
        let data:[String: Any] = ["transaction_id": result.transactionId!, "status": result.transactionStatus!]
        
        guard let paymentListener = paymentListener else {
            return
        }
        paymentListener(data)
    }
    
    func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentSuccess result: MidtransTransactionResult!) {
        let data:[String: Any] = ["transaction_id": result.transactionId!, "status": result.transactionStatus!]
        
        guard let paymentListener = paymentListener else {
            return
        }
        paymentListener(data)
    }
    
    func paymentViewController(_ viewController: MidtransUIPaymentViewController!, paymentFailed error: Error!) {
        let data:[String: Any] = ["transaction_id": "", "status": "Payment"]
        
        guard let paymentListener = paymentListener else {
            return
        }
        paymentListener(data)
    }
    
    func paymentViewController_paymentCanceled(_ viewController: MidtransUIPaymentViewController!) {
        let data:[String: Any] = ["transaction_id": "", "status": "Payment Canceled"]
        
        guard let paymentListener = paymentListener else {
            return
        }
        paymentListener(data)
    }
}
