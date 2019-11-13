package com.common.aws.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import com.amazonaws.util.IOUtils;

@Service
@Transactional(rollbackFor = Exception.class)
public class AwsService {

	@Autowired
	private AmazonS3 s3Client;

	public void uploadObject(String filePath, MultipartFile multipartFile, String storedFileName) throws IOException {

		ObjectMetadata omd = new ObjectMetadata();
		omd.setContentType(multipartFile.getContentType());
		omd.setContentLength(multipartFile.getSize());
		omd.setHeader("filename", multipartFile.getOriginalFilename());

		// Copy file to the target location (Replacing existing file with the same name)
		s3Client.putObject(new PutObjectRequest(filePath, storedFileName,
				multipartFile.getInputStream(), omd));

	}

	public void deleteObject(String filePath, String storedFileName) throws AmazonServiceException {

		s3Client.deleteObject(new DeleteObjectRequest(filePath, storedFileName));

	}

	public Resource getObject(String filePath, String storedFileName) throws IOException {
		S3Object o = s3Client.getObject(new GetObjectRequest(filePath, storedFileName));
		S3ObjectInputStream objectInputStream = o.getObjectContent();
		byte[] bytes = IOUtils.toByteArray(objectInputStream);
		
		Resource resource = new ByteArrayResource(bytes);
		return resource;
	}
}
