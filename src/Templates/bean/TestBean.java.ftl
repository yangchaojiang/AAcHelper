<#include "../commnt/file_package_improt.ftl">;


import android.os.Parcel;
import android.os.Parcelable;
<#if dataType==3>
import com.chad.library.adapter.base.entity.MultiItemEntity;
</#if>
<#include "../commnt/file_header_info.ftl">

public class ${beanBean} implements Parcelable<#if dataType==3>,MultiItemEntity</#if>{


    protected ${beanBean}(Parcel in) {
    }
    
    @Override
    public void writeToParcel(Parcel dest, int flags) {
    }
    @Override
    public int describeContents() {
        return 0;
    }

    public static final Creator<${beanBean}> CREATOR = new Creator<${beanBean}>() {
        @Override
        public ${beanBean} createFromParcel(Parcel in) {
            return new ${beanBean}(in);
        }

        @Override
        public ${beanBean}[] newArray(int size) {
            return new ${beanBean}[size];
        }
    };
<#if dataType==3>
    @Override
    public int getItemType() {
        return 0;
    }
</#if>
}
