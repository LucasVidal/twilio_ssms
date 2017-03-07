package com.twilio.lvidal.ssms_android

import android.content.Context
import com.twilio.lvidal.ssms_android.fragment.SMSListFragment
import com.twilio.lvidal.ssms_android.model.User
import com.twilio.lvidal.ssms_android.network.NetworkModule
import com.twilio.lvidal.ssms_android.network.SSMSAPI
import com.twilio.lvidal.ssms_android.network.UploadKeyResult
import dagger.Component
import dagger.Module
import dagger.Provides
import retrofit2.Call
import retrofit2.Retrofit
import javax.inject.Singleton

/**
 * Created by lvidal on 3/6/17.
 */
@Singleton
@Component(modules = arrayOf(
        AppModule::class,
        SSMSModule::class,
        NetworkModule::class)
)
interface SSMSComponent {

    fun inject(smsListFragment: SMSListFragment)

}

@Module
class AppModule(val app: SSMSApp) {

    @Provides
    @Singleton
    fun provideContext(): Context {
        return app;
    }

    @Provides
    @Singleton
    fun provideApplication(): SSMSApp {
        return app;
    }
}
@Module
class SSMSModule {

    @Provides
    @Singleton
    fun provideNewsAPI(ssmsApi: SSMSAPI): SSMSAPI {
        return SSMSRestAPI(ssmsApi)
    }

    @Provides
    @Singleton
    fun provideRedditApi(retrofit: Retrofit): SSMSAPI {
        return retrofit.create(SSMSAPI::class.java)
    }
    /**
     * SSMSManager is automatically provided by Dagger as we set the @Inject annotation in the
     * constructor, so we can avoid adding a 'provider method' here.
     */
}

interface  RedditApi {
    @GET("/top.json")
    fun getTop(@Query("after") after: String,
               @Query("limit") limit: String): Call<RedditNewsResponse>;
}