package com.twilio.lvidal.ssms_android.network

import com.twilio.lvidal.ssms_android.model.User
import retrofit2.Call

/**
 * Created by lvidal on 3/6/17.
 */
interface SMSAPI {
    fun uploadKey(user : User) : Call<UploadKeyResult>
}

interface  RedditApi {
    @GET("/top.json")
    fun getTop(@Query("after") after: String,
               @Query("limit") limit: String): Call<RedditNewsResponse>;
}
