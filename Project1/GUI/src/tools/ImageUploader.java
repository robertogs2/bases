package tools;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.awt.*;
import java.io.File;
import java.util.Map;


public class ImageUploader {

   private final Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "cb-dev-cloud",
            "api_key", "314318781352197",
            "api_secret", "OFXMjiyNfl4Q-jImA45DSLu6OL0"));

    private static ImageUploader instance;

    protected ImageUploader(){

    }


    public static ImageUploader getInstance(){
        if(instance == null)instance = new ImageUploader();
        return instance;
    }

    public String uploadImage(String name, File file) throws Exception{
        Map params = ObjectUtils.asMap(
                "public_id", "DB/project1/" + name,
                "overwrite", true,
                "notification_url", "https://requestb.in/12345abcd",
                "resource_type", "image"
        );
        Map uploadResult = cloudinary.uploader().upload(file, params);
        return uploadResult.get("url").toString();
    }
}
