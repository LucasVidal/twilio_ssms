package com.twilio.lvidal.ssms_android.model

/**
 * Created by lvidal on 3/4/17.
 */

data class User (
    val userName : String,
    val privateKey : String,
    val publicKey : String,
    val phoneNumber : String
)
