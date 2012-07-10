package com.sticksports.nativeExtensions.flurry;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.flurry.android.FlurryAgent;

public class FlurrySetSecureTransportEnabled implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		try
		{
			boolean secure = args[0].getAsBool();
			FlurryAgent.setUseHttps( secure );
		}
		catch ( Exception exception )
		{
			Log.w( "Flurry", exception );
		}
		return null;
	}
}
