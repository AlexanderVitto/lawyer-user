package com.example.my_psycho


import android.annotation.SuppressLint
import android.app.NotificationManager
import android.content.Context
import android.os.Bundle
import android.os.PersistableBundle
import android.widget.Toast
import com.example.my_psycho.payment.DataCustomer
import com.midtrans.sdk.corekit.callback.TransactionFinishedCallback
import com.midtrans.sdk.corekit.core.MidtransSDK
import com.midtrans.sdk.corekit.core.themes.CustomColorTheme
import com.midtrans.sdk.corekit.models.snap.TransactionResult
import com.midtrans.sdk.uikit.SdkUIFlowBuilder

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity(), TransactionFinishedCallback, EventChannel.StreamHandler {
    private var statusChannel: EventChannel.EventSink? = null

    companion object {
        const val CHANNEL = "com.example.local_psykay.payment_gateway";
        const val KEY_NATIVE = "showMidtrans";
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->

            when (call.method) {
                "showMidtrans" -> midtrans(call, result)
                else -> result.notImplemented()
            }

        }

        EventChannel(flutterEngine?.dartExecutor?.binaryMessenger, "com.example.local_psykay.payment_gateway/status").setStreamHandler(this)
    }

    private fun midtrans(call: MethodCall, result: MethodChannel.Result) {
        val dict = call.arguments as HashMap<String, Any>


        initMidtransSdk()

        MidtransSDK.getInstance().transactionRequest = DataCustomer.transactionRequest(dict)

        MidtransSDK.getInstance().startPaymentUiFlow(this)

        result.success("success")
    }

    private fun initMidtransSdk() {
        SdkUIFlowBuilder.init()
                .setClientKey(BuildConfig.MERCHANT_CLIENT_KEY)
                .setContext(this)
                .setTransactionFinishedCallback(this)
                .setMerchantBaseUrl(BuildConfig.MERCHANT_BASE_URL)
                .enableLog(false)
                .setColorTheme(CustomColorTheme("#FFE51255", "#B61548", "#FFE51255"))
                .setLanguage("id")
                .buildSDK()
    }

    private fun closeAllNotifications(){
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.cancelAll()
    }

    @SuppressLint("ShowToast")
    override fun onTransactionFinished(result: TransactionResult) {
         when {
            result.response != null -> {

                when (result.status) {
                    TransactionResult.STATUS_SUCCESS -> Toast.makeText(this, "Transaction Finished ID : " + result.response.transactionId, Toast.LENGTH_SHORT).show()
                    TransactionResult.STATUS_PENDING -> {
                        Toast.makeText(this, "Transaction Pending ID : " + result.response.transactionId, Toast.LENGTH_SHORT).show()

                    }
                    TransactionResult.STATUS_FAILED -> Toast.makeText(this, "Transaction Failed ID : " + result.response.transactionId, Toast.LENGTH_SHORT).show()

                }
                result.response.validationMessages
                statusChannel?.success(hashMapOf("transaction_id" to result.response.transactionId, "order_id" to result.response.orderId,
                        "status" to result.status,"payment_type" to result.response.paymentType, "permata_va_number" to result.response.permataVANumber, "bca_va_number" to result.response.bcaVaNumber,"bni_va_number" to result.response.bniVaNumber,
                        "bri_va_number" to result.response.briVaNumber, "payment_code" to result.response.paymentCode, "bank" to result.response.bank,
                        "bill_key" to result.response.paymentCode, "biller_code" to result.response.companyCode))

            }
            result.isTransactionCanceled -> {
                Toast.makeText(this, "Transaction Canceled", Toast.LENGTH_SHORT).show()
                statusChannel?.success(hashMapOf("transaction_id" to "",
                        "status" to "canceled"))

            }
            else -> {
                if (result.status.equals(TransactionResult.STATUS_INVALID, ignoreCase = true)) {
                    Toast.makeText(this, "Transaction Invalid", Toast.LENGTH_SHORT).show()
                } else {
                    Toast.makeText(this, "Transaction Finished with failure", Toast.LENGTH_SHORT).show()
                }

                statusChannel?.success(hashMapOf("transaction_id" to "",
                        "status" to result.status))
            }
        }
    }

    override fun onResume() {
        super.onResume()

        closeAllNotifications()
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        statusChannel = events
    }

    override fun onCancel(arguments: Any?) {
        statusChannel = null
    }


}
