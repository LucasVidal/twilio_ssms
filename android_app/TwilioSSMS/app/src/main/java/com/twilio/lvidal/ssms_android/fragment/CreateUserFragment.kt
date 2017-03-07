package com.twilio.lvidal.ssms_android.fragment

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

/**
 * Created by lvidal on 3/4/17.
 */

class CreateUserFragment : Fragment {

    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        //improve with this
        val view = inflater.inflate(R.layout.fragment_create_user, container, false)


        return view
    }
}
