package com.sticksports.nativeExtensions.flurry;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.flurry.android.FlurryAgent;

public class FlurrySetSessionContinueSeconds implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		try
		{
			long version = args[0].getAsInt();
			FlurryAgent.setContinueSessionMillis( version * 1000 );
		}
		catch ( Exception exception )
		{
			Log.w( "Flurry", exception );
		}
		return null;
	}
}
