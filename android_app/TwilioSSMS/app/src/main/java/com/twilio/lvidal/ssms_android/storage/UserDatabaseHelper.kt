package com.twilio.lvidal.ssms_android.storage

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import com.twilio.lvidal.ssms_android.model.User


/**
 * Created by lvidal on 3/4/17.
 */


class UserDatabaseHelper internal constructor(context: Context)
    : SQLiteOpenHelper(context, DATABASE_NAME, null, UserDatabaseHelper.DATABASE_VERSION) {

    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL(DICTIONARY_TABLE_CREATE)
    }

    override fun onUpgrade(db: SQLiteDatabase?, oldVersion: Int, newVersion: Int) {
        TODO("not implemented")
    }

    fun getStoredUser() : User? {
        val cursor = readableDatabase.query(USERS_TABLE_NAME, null, null, null, null, null, null)
        if (cursor.count == 0) {
            return null
        }

        val username = cursor.getString(0)
        val phoneNumber = cursor.getString(1)
        val privateKey = cursor.getString(2)
        val publicKey = cursor.getString(3)

        return User(username, phoneNumber, privateKey, publicKey)
    }

    fun storeUser(user : User) {
        val values = ContentValues()
        values.put(KEY_USERNAME, user.userName)
        values.put(KEY_PHONE_NUMBER, user.phoneNumber)
        values.put(KEY_PRIVATE_KEY, user.privateKey)
        values.put(KEY_PUBLIC_KEY, user.publicKey)

        writableDatabase.delete(USERS_TABLE_NAME, null, null)   //remove other users if stored
        writableDatabase.insert(USERS_TABLE_NAME, null, values)
    }

    companion object {

        private val DATABASE_VERSION = 2
        private val DATABASE_NAME = "SSMS_KEYS"
        private val USERS_TABLE_NAME = "users"

        private val KEY_USERNAME = "username"
        private val KEY_PHONE_NUMBER = "phone_number"
        private val KEY_PRIVATE_KEY = "private_key"
        private val KEY_PUBLIC_KEY = "public_key"

        private val DICTIONARY_TABLE_CREATE =
                "CREATE TABLE " + USERS_TABLE_NAME + " (" +
                        KEY_USERNAME + " TEXT, " +
                        KEY_PHONE_NUMBER + " TEXT, " +
                        KEY_PRIVATE_KEY + " TEXT, " +
                        KEY_PUBLIC_KEY + " TEXT);"

    }
}

