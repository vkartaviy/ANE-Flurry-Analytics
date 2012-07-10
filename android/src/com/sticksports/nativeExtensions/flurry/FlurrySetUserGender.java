package com.sticksports.nativeExtensions.flurry;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.flurry.android.Constants;
import com.flurry.android.FlurryAgent;

public class FlurrySetUserGender implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		try
		{
			String genderString = args[0].getAsString();
			byte gender = genderString == "f" ? Constants.FEMALE : Constants.MALE;
			FlurryAgent.setGender( gender );
		}
		catch ( Exception exception )
		{
			Log.w( "Flurry", exception );
		}
		return null;
	}
}
