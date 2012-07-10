package com.sticksports.nativeExtensions.flurry;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class FlurryExtension implements FREExtension
{
	@Override
	public FREContext createContext( String arg0 )
	{
		return new FlurryExtensionContext();
	}

	@Override
	public void dispose()
	{
	}

	@Override
	public void initialize()
	{
	}
}
