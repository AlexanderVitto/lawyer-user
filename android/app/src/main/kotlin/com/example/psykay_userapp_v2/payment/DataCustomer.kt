package com.example.my_psycho.payment

import com.midtrans.sdk.corekit.core.TransactionRequest
import com.midtrans.sdk.corekit.models.*

object DataCustomer {
    fun transactionRequest(dict: HashMap<String, Any>): TransactionRequest {
        val total = dict.get("total") as Double
        val orderId = dict.get("orderId") as String
        val email = dict.get("email") as String
        val firstName = dict.get("firstName") as String
        val lastName = dict.get("lastName") as String
        val phone = dict.get("phone") as String
        val address = dict.get("address") as String
        val city = dict.get("city") as String
        val postalCode = dict.get("postalCode") as String
        val items = dict.get("items") as ArrayList<HashMap<String, Any>>
        val transactionRequest = TransactionRequest(orderId, total)

        val itemList = items.map { ItemDetails(it["id"] as String, it["price"] as Double, 1, it["booking_code"] as String); }
        transactionRequest.itemDetails = java.util.ArrayList(itemList)

        val customerDetails = CustomerDetails()
        customerDetails.customerIdentifier = firstName+"-"+orderId
        customerDetails.phone = phone
        customerDetails.firstName = firstName
        customerDetails.lastName = lastName
        customerDetails.email = email


        val shippingAddress = ShippingAddress()
        shippingAddress.address = address
        shippingAddress.city = city
        shippingAddress.postalCode = postalCode
        customerDetails.shippingAddress = shippingAddress

        val billingAddress = BillingAddress()
        billingAddress.address = address
        billingAddress.city = city
        billingAddress.postalCode = postalCode
        customerDetails.billingAddress = billingAddress

        transactionRequest.customerDetails = customerDetails

        return transactionRequest
    }
}