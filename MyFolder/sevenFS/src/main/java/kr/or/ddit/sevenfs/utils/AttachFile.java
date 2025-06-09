package kr.or.ddit.sevenfs.utils;

import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.sevenfs.service.AttachFileService;
import kr.or.ddit.sevenfs.vo.AttachFileVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.DecimalFormat;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Slf4j
@Component
public class AttachFile {
    @Value("${file.save.abs.path}")
    private String saveDir;

    // svn 업로드 폴더 안에 추가
    // String saveDir = "/Users/heoseongjin/Documents/GitHub/ddit/05_LAST/upload/";

    // 실제 파일 저장 메소드
    public List<AttachFileVO> fileRealSave(String dir, MultipartFile[] files, Long atchFileNo, int atchFileSn) {
        List<AttachFileVO> attachFileVOList = new ArrayList<>();
        folderMkdirs(dir);
        // 저장된 파일 인경우는 넘겨줘야힘

        // int atchFileSn = attachFileService.getAttachFileSn(atchFileNo);

        for (MultipartFile file : files) {
            if (file.getSize() == 0) continue;

            String saveName = UUID.randomUUID().toString().replace("-", "") + "_" + file.getOriginalFilename();
            File path = new File(saveDir + dir + "/" + saveName);

            try {
                file.transferTo(path);

                AttachFileVO attachFileVO = new AttachFileVO();
                attachFileVO.setAtchFileNo(atchFileNo);
                attachFileVO.setFileSn(atchFileSn++);
                attachFileVO.setFileStrePath(dir + "/" + saveName);
                attachFileVO.setFileNm(file.getOriginalFilename());
                attachFileVO.setFileStreNm(saveName);
                attachFileVO.setFileSize(file.getSize());
                attachFileVO.setFileMime(file.getContentType());
                attachFileVO.setFileExtsn(
                    Objects.requireNonNull(file.getOriginalFilename()).substring(file.getOriginalFilename().lastIndexOf(".") + 1)
                );
                attachFileVO.setFileViewSize(makeFancySize(file.getSize() + ""));

                attachFileVOList.add(attachFileVO);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        return attachFileVOList;
    }


    // 진짜 파일 삭제
    public void deleteRealFiles(List<AttachFileVO> attachFileVOList) {
        attachFileVOList.forEach((fileAttachVO) -> {
            Path filePath = Paths.get(saveDir + fileAttachVO.getFileStrePath());

            try {
                if (Files.deleteIfExists(filePath)) {
                    log.info("파일 삭제 성공: {}", filePath);
                } else {
                    log.warn("파일이 존재하지 않아 삭제할 수 없음: {}", filePath);
                }
            } catch (IOException e) {
                log.error("파일 삭제 실패: {}", filePath, e);
            }

        });
    }

    // 파일 다운로드
    public ResponseEntity<Resource> download(String fileName) {
        Resource resource = null;
        HttpHeaders headers = null;
        //resource : 다운로드 받을 파일(자원)
        resource = new FileSystemResource(saveDir + fileName);

        //메타데이터(데이터를 위한 데이터-눈에 보이지 않는 정보)
        String resourceName = resource.getFilename();
        //다운로드는 응답 헤더(파일명) + 응답 바디(파일데이터)를 통해서 진행됨
        headers = new HttpHeaders();

        //            헤더명                      값
        headers.add("Content-Disposition",
                "attachment;filename=" + new String(resourceName.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1)
        );

        //응답 body -> 파일 데이터
        return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
    }

    // 폴더 생성
    public void folderMkdirs(String dir) {
        File folder = new File(saveDir + dir);
        if (!folder.exists() && !folder.mkdirs()) {
            log.error("폴더 생성 실패: {}", folder);
        }
    }

    // fancySize 리턴("1059000")
    public String makeFancySize(String bytes) {
        if (bytes.equals("0")) return "0 bytes";
        double size = Double.parseDouble(bytes);
        String[] s = {"bytes", "KB", "MB", "GB", "TB", "PB"};
        int idx = (int) Math.floor(Math.log(size) / Math.log(1024));
        return new DecimalFormat("#,###.##").format(size / Math.pow(1024, idx)) + " " + s[idx];
    }

    // 파일 zip만들기
    public void makeZip(List<AttachFileVO> attachFileVOList, String folderName, HttpServletResponse response) throws IOException {
        try (ZipOutputStream zipOut = new ZipOutputStream(response.getOutputStream())) {
            for (AttachFileVO attachFileVO : attachFileVOList) {
                String fileStrePath = attachFileVO.getFileStrePath();
                System.out.println(fileStrePath);

                File file = new File( saveDir + fileStrePath);
                if (file.exists()) {
                    try (FileInputStream fileInputStream = new FileInputStream(file)) {
                        ZipEntry zipEntry = new ZipEntry(file.getName()); // 진짜 파일 zip 파일에 추가
                        zipOut.putNextEntry(zipEntry);

                        byte[] bytes = new byte[1024];
                        int len;
                        while ((len = fileInputStream.read(bytes)) != -1) {
                            zipOut.write(bytes, 0, len);
                        }

                        zipOut.closeEntry();
                    }
                }
            }
            zipOut.finish();
        }
    }

    // 파일 이동

    /**
     *
     * @param folder - 부모가 되는 폴더
     * @param file - 이동하는 파일 또는 폴더
     * @return
     * @throws IOException
     */
    public Map<String, String> moveFile(String folder, String file) throws IOException {
        Map<String, String> result = new HashMap<>();
        String targetFolderPath = saveDir + folder;
        Path targetFolder = Paths.get(targetFolderPath);

        if (Files.exists(targetFolder)) {
            String filePath = saveDir + file;
            Path moveFile = Paths.get(filePath);

            if (Files.exists(moveFile)) {
                // 목적지 경로 (디렉토리 + 파일 이름)
                Path targetPath = targetFolder.resolve(moveFile.getFileName());
                Files.move(moveFile, targetPath, StandardCopyOption.ATOMIC_MOVE); // 있는경우 에러 던지기

                result.put("result", "success");
                result.put("message", "파일 이동 성공");
            } else {

                result.put("result", "fail");
                result.put("message", "원본 파일이 존재하지 않습니다.");
            }
        } else {
            result.put("result", "fail");
            result.put("message", "타겟 폴더가 존재하지 않습니다.");
        }

        return result;
    }

    // 바이너리 파일 저장
//    public String uploadFileToBinary(String dir, String file) {
//        byte[] decodedFile = Base64.getDecoder().decode(file.split(",")[1]);
//
//        String saveName = UUID.randomUUID().toString().replace("-", "");
//        Path filePath = Paths.get(saveDir + dir + "/" + saveName);
//
//        try {
//            log.debug("filePath => {}", filePath);
//            Files.write(filePath, decodedFile);
//            log.info("파일 저장 완료: {}", filePath.toString());
//        } catch (IOException e) {
//            log.error("파일 저장 중 오류 발생", e);
//        }
//
//        return "/" + dir + "/" + saveName;
//    }
}
