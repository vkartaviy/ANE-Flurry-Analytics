package com.sticksports.nativeExtensions.flurry;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.flurry.android.FlurryAgent;

public class FlurrySetAppVersion implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		try
		{
			String version = args[0].getAsString();
			FlurryAgent.setVersionName( version );
		}
		catch ( Exception exception )
		{
			Log.w( "Flurry", exception );
		}
		return null;
	}
}
