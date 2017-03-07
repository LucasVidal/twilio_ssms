package com.twilio.lvidal.ssms_android

import android.os.Bundle
import android.support.v4.app.Fragment
import android.support.v4.app.FragmentManager
import android.support.v7.app.AppCompatActivity
import com.twilio.lvidal.ssms_android.fragment.CreateUserFragment
import com.twilio.lvidal.ssms_android.fragment.SMSListFragment
import com.twilio.lvidal.ssms_android.storage.UserDatabaseHelper

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val dbHelper = UserDatabaseHelper(this)
        if (savedInstanceState == null) {
            if (dbHelper.getStoredUser() == null) {
                changeFragment(CreateUserFragment());
            } else {
                changeFragment(SMSListFragment());
            }
        }
    }

    fun changeFragment(f: Fragment, cleanStack: Boolean = false) {
        val ft = supportFragmentManager.beginTransaction();
        if (cleanStack) {
            clearBackStack();
        }
        ft.replace(R.id.activity_base_content, f);
        ft.addToBackStack(null);
        ft.commit();
    }


    fun clearBackStack() {
        val manager = supportFragmentManager;
        if (manager.backStackEntryCount > 0) {
            val first = manager.getBackStackEntryAt(0);
            manager.popBackStack(first.id, FragmentManager.POP_BACK_STACK_INCLUSIVE);
        }
    }

}
