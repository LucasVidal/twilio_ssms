package com.twilio.lvidal.ssms_android.network

import com.twilio.lvidal.ssms_android.model.User
import java.util.*
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Created by lvidal on 3/6/17.
 */

@Singleton
class SSMSManager @Inject constructor(private val api: SSMSAPI) {

    fun uploadKey(user: User): Observable<UploadKeyResult> {
        return Observable.create {
            subscriber ->
            val callResponse = api.uploadKey(user)
            val response = callResponse.execute()

            if (response.isSuccessful) {
                subscriber.onNext(response.body().result)
                subscriber.onCompleted()
            } else {
                subscriber.onError(Throwable(response.body().result))
            }
        }
    }
}
    /**
     *
     * Returns Reddit News paginated by the given limit.
     *
     * @param after indicates the next page to navigate.
     * @param limit the number of news to request.
     */
//    fun getNews(after: String, limit: String = "10"): Observable<RedditNews> {
//        return Observable.create {
//            subscriber ->
//            val callResponse = api.getNews(after, limit)
//            val response = callResponse.execute()
//
//            if (response.isSuccessful) {
//                val dataResponse = response.body().data
//                val news = dataResponse.children.map {
//                    val item = it.data
//                    RedditNewsItem(item.author, item.title, item.num_comments,
//                            item.created, item.thumbnail, item.url)
//                }
//                val redditNews = RedditNews(
//                        dataResponse.after ?: "",
//                        dataResponse.before ?: "",
//                        news)
//
//                subscriber.onNext(redditNews)
//                subscriber.onCompleted()
//            } else {
//                subscriber.onError(Throwable(response.message()))
//            }
//        }
//    }
}

