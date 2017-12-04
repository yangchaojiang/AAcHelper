<#include "../commnt/file_package_improt.ftl">


import android.os.Parcel
import android.os.Parcelable


<#include "../commnt/file_header_info.ftl">

class ${beanBean}(`in`: Parcel) : Parcelable {

    override fun writeToParcel(dest: Parcel, flags: Int) {}

    override fun describeContents(): Int {
        return 0
    }

    companion object {

        val CREATOR: Parcelable.Creator<${beanBean}> = object : Parcelable.Creator<${beanBean}> {
            override fun createFromParcel(`in`: Parcel): ${beanBean} {
                return ${beanBean}(`in`)
            }

            override fun newArray(size: Int): Array<${beanBean}?> {
                return arrayOfNulls(size)
            }
        }
    }
}
