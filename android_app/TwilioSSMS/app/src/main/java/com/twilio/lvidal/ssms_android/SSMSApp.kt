package com.twilio.lvidal.ssms_android

import android.app.Application
import com.droidcba.kedditbysteps.di.AppModule
import com.droidcba.kedditbysteps.di.news.DaggerNewsComponent
import com.droidcba.kedditbysteps.di.news.NewsComponent

/**
 * Created by lvidal on 3/6/17.
 */
class SSMSApp : Application() {

    companion object {
        lateinit var ssmsComponent: SsmsComponent
    }

    override fun onCreate() {
        super.onCreate()
        ssmsComponent = DaggerSSMSComponent.builder()
                .appModule(AppModule(this))
                //.newsModule(NewsModule()) Module with empty constructor is implicitly created by dagger.
                .build()
    }
}