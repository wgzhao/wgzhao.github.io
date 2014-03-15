// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(3) 
// Source File Name: ClientKey.java

package com.aptana.ide.core.licensing;

import java.util.Calendar;
import java.util.TimeZone;

public final class ClientKey
{

 public ClientKey(int type, String email, long expiration)
 {
 this.type = type;
 this.email = email;
 this.expiration = expiration;
 }

 public boolean isCloseToExpiring()
 {
 return false; //not close
 /*Calendar currentCalendar = Calendar.getInstance(GMT);
 currentCalendar.add(2, 1);
 return getExpiration().before(currentCalendar);*/
 }

 public boolean isValid()
 {
 return true; //success
 //return email != null && email != "EMAILS_NON_MATCHING";

 }

 public boolean isCloseToMatching()
 {
 return false; //close
 //return email == "EMAILS_NON_MATCHING";
 }

 public boolean isExpired()
 {
 return false; //not trial edition
 // Calendar currentCalendar = Calendar.getInstance(GMT);
 // return currentCalendar.after(getExpiration());
 }

 public String getEmail()
 {
 return email;
 }

 public Calendar getExpiration()
 {
 Calendar expirationCal = Calendar.getInstance(GMT);
 expirationCal.setTimeInMillis(expiration);
 return expirationCal;
 }

 public boolean isTrial()
 {
 return false;
 //return type == 1;
 
 }

 public boolean isPro()
 {
 return true;
 // return !isTrial();
 }

 public boolean shouldProPluginsRun()
 {
 if(isPro())
 return true;
 else
 return !isExpired();
 }

 public static String trimEncryptedLicense(String encrypted)
 {
 String newEncrypted = encrypted;
 newEncrypted = newEncrypted.trim();
 newEncrypted = newEncrypted.replaceAll("--begin-aptana-license--",
"");
 newEncrypted = newEncrypted.replaceAll("--end-aptana-license--", "");
 newEncrypted = newEncrypted.replaceAll("s+", "");
 return newEncrypted;
 }

 public static final String BEGIN_LICENSE_MARKER =
"--begin-aptana-license--";
 public static final String END_LICENSE_MARKER =
"--end-aptana-license--";
 public static final int PRO = 0;
 public static final int TRIAL = 1;
 private static final TimeZone GMT = TimeZone.getTimeZone("GMT");
 public static final String EMAILS_NON_MATCHING =
"EMAILS_NON_MATCHING";
 public static final ClientKey EMPTY_KEY = new ClientKey(1, null, 0L);
 private String email;
 private long expiration;
 private int type;

}

