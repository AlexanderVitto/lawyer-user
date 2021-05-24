package com.example.my_psycho.payment

import com.midtrans.sdk.corekit.core.TransactionRequest
import com.midtrans.sdk.corekit.models.*

object DataCustomer {
    fun transactionRequest(total: Double, orderId: String, items: ArrayList<HashMap<String, Any>>): TransactionRequest {
        val transactionRequest = TransactionRequest(orderId, total)

        val itemList = items.map { ItemDetails(it["id"] as String, it["price"] as Double, 1, it["booking_code"] as String); }
        transactionRequest.itemDetails = java.util.ArrayList(itemList)

        val customerDetails = CustomerDetails()
        customerDetails.customerIdentifier = "budi-6789"
        customerDetails.phone = "08123456789"
        customerDetails.firstName = "Budi"
        customerDetails.lastName = "Utomo"
        customerDetails.email = "budi@utomo.com"


        val shippingAddress = ShippingAddress()
        shippingAddress.address = "Jalan Andalas Gang Sebelah No. 1"
        shippingAddress.city = "Jakarta"
        shippingAddress.postalCode = "10220"
        customerDetails.shippingAddress = shippingAddress

        val billingAddress = BillingAddress()
        billingAddress.address = "Jalan Andalas Gang Sebelah No. 1"
        billingAddress.city = "Jakarta"
        billingAddress.postalCode = "10220"
        customerDetails.billingAddress = billingAddress

        transactionRequest.customerDetails = customerDetails

        return transactionRequest
    }
}