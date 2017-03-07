package com.twilio.lvidal.ssms_android.fragment

import android.view.View

/**
 * Created by lvidal on 3/4/17.
 */

class SMSListFragment : RxBaseFragment(), SMSListDelegateAdapter.onViewSelectedListener {
}

interface SMSListDelegateAdapter {
    interface onViewSelectedListener {
        fun onViewSelected()
    }

}

interface ViewType {
    fun getViewType(): Int
}


