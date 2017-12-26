package com.ese.service.manage.download;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.manage.download.UploadMapper;
import com.ese.vo.notice.DownloadNotice;
import com.ese.vo.notice.FileAttach;

@Service
public class UploadServiceImpl implements UploadService {

	@Autowired
	UploadMapper uploadMapper;
	
	@Override
	public List<DownloadNotice> getAllUpload() {
		return uploadMapper.getAllUpload();
	}
	
	@Override
	public int getUploadSeq() {
		return uploadMapper.getUploadSeq();
	}
	
	@Override
	public void addUpload(DownloadNotice downloadNotice) {
		int uploadNo = uploadMapper.getUploadSeq();
		downloadNotice.setNo(uploadNo);
		uploadMapper.addUpload(downloadNotice);
	}
	
	@Override
	public void addFile(FileAttach fileAttach) {
		int fileNo = uploadMapper.getFileNoSeq();
		fileAttach.setNo(fileNo);
		uploadMapper.addFile(fileAttach);
	}
	
	@Override
	public FileAttach getFileNoByName(String name) {
		return uploadMapper.getFileNoByName(name);
	}
	
	@Override
	public DownloadNotice getUploadByNo(int fileNo) {
		return uploadMapper.getUploadByNo(fileNo);
	}
}
