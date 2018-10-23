package cn.vimfung.luascriptcore.modules.foundation;

import android.content.Context;
import android.content.pm.PackageManager;
import android.content.res.AssetFileDescriptor;
import android.os.Environment;

import java.io.File;
import java.io.IOException;

import cn.vimfung.luascriptcore.LuaEnv;
import cn.vimfung.luascriptcore.LuaExportType;

import static android.os.Environment.MEDIA_MOUNTED;

/**
 * 路径信息
 */
public final class Path implements LuaExportType
{
    /**
     * 获取应用所在目录
     * @return 路径信息
     */
    public static String app()
    {
        Context applicationContext = LuaEnv.defaultEnv().getAndroidApplicationContext();
        return applicationContext.getPackageResourcePath();
    }

    /**
     * 获取应用根目录
     * @return 路径信息
     */
    public static String home()
    {
        Context applicationContext = LuaEnv.defaultEnv().getAndroidApplicationContext();

        File homeDir = null;

        int perm = applicationContext.checkCallingOrSelfPermission("android.permission.WRITE_EXTERNAL_STORAGE");
        if (MEDIA_MOUNTED.equals(Environment.getExternalStorageState()) &&  perm == PackageManager.PERMISSION_GRANTED)
        {
            homeDir = applicationContext.getExternalFilesDir(null);
        }

        if (homeDir == null)
        {
            homeDir = applicationContext.getFilesDir();
        }

        if (homeDir != null && !homeDir.exists())
        {
            homeDir.mkdirs();
        }

        return homeDir.getAbsolutePath();
    }

    /**
     * 获取应用文档目录
     * @return 路径信息
     */
    public static String docs()
    {
        Context applicationContext = LuaEnv.defaultEnv().getAndroidApplicationContext();

        File docDir = null;

        int perm = applicationContext.checkCallingOrSelfPermission("android.permission.WRITE_EXTERNAL_STORAGE");
        if (MEDIA_MOUNTED.equals(Environment.getExternalStorageState()) &&  perm == PackageManager.PERMISSION_GRANTED)
        {
            docDir = applicationContext.getExternalFilesDir("Documents");
        }

        if (docDir == null)
        {

            docDir = new File(applicationContext.getFilesDir(), "Documents");
        }

        if (!docDir.exists())
        {
            docDir.mkdirs();
        }

        return docDir.getAbsolutePath();
    }

    /**
     * 获取应用缓存目录
     * @return 路径信息
     */
    public static String caches()
    {
        Context applicationContext = LuaEnv.defaultEnv().getAndroidApplicationContext();

        File appCacheDir = null;

        int perm = applicationContext.checkCallingOrSelfPermission("android.permission.WRITE_EXTERNAL_STORAGE");
        if (MEDIA_MOUNTED.equals(Environment.getExternalStorageState()) &&  perm == PackageManager.PERMISSION_GRANTED)
        {
            appCacheDir = applicationContext.getExternalCacheDir();
        }

        if (appCacheDir == null)
        {

            appCacheDir = applicationContext.getCacheDir();
        }

        if (appCacheDir != null && !appCacheDir.exists())
        {
            appCacheDir.mkdirs();
        }

        return appCacheDir.getAbsolutePath();
    }

    /**
     * 获取临时目录信息
     * @return 路径信息
     */
    public static String tmp()
    {
        Context applicationContext = LuaEnv.defaultEnv().getAndroidApplicationContext();

        File docDir = null;

        int perm = applicationContext.checkCallingOrSelfPermission("android.permission.WRITE_EXTERNAL_STORAGE");
        if (MEDIA_MOUNTED.equals(Environment.getExternalStorageState()) &&  perm == PackageManager.PERMISSION_GRANTED)
        {
            docDir = applicationContext.getExternalFilesDir("tmp");
        }

        if (docDir == null)
        {
            docDir = new File(applicationContext.getFilesDir(), "tmp");
        }

        if (!docDir.exists())
        {
            docDir.mkdirs();
        }

        return docDir.getAbsolutePath();
    }


    /**
     * 判断指定路径是否存在
     * @param path  文件路径
     * @return  true 存在，false 不存在
     */
    public static boolean exists(String path)
    {
        boolean exists = false;
        if (!path.startsWith("/"))
        {
            AssetFileDescriptor fd = null;
            try
            {
                fd = LuaEnv.defaultEnv().getAndroidApplicationContext().getAssets().openFd(path);
                if (fd != null)
                {
                    exists = true;
                }
            }
            catch (IOException e)
            {
                //不存在文件
            }

        }
        else if (path.startsWith(Path.app()))
        {
            String fileName = path.substring(Path.app().length() + 1);
            AssetFileDescriptor fd = null;
            try
            {
                fd = LuaEnv.defaultEnv().getAndroidApplicationContext().getAssets().openFd(fileName);
                if (fd != null)
                {
                    exists = true;
                }
            }
            catch (IOException e)
            {
                //不存在文件
            }
        }
        else
        {
            File file = new File(path);
            exists = file.exists();
        }


        return exists;
    }
}
