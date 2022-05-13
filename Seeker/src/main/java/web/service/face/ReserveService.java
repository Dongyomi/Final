package web.service.face;

import java.util.List;

import web.dto.GardenPriceDto;
import web.dto.ReserveInfo;

public interface ReserveService {

	
	/**
	 * 전체 수목원 목록을 불러온다.
	 * 
	 * @return 수목원 이름이 적힌 list 객체*/
	public List<String> getGardenList();

	
	/**
	 * 이름이 일치하는 수목원의 가격 정보를 불러온다. 
	 * @param garden 
	 * @return 해당 수목원의 가격 DTO */
	public GardenPriceDto getGardenPrice(String garden);

	/**
	 * 예약 내역을 저장한다. 
	 * @param 예약 내역이 들어있는 DTO
	 * */
	public void saveResInfo(ReserveInfo info);

	/**
	 * 오라클에서 자동 생성된 예약번호를 불러온다. 
	 * @param memberNo 예약한 사람의 유저넘버
	 * @return 예약번호
	 * */
	public int getReserveNo(int memberNo);

	/**
	 * 예약번호를 통해 예약 내역을 불러온다. 
	 * @param 예약번호
	 * @return 예약내역 DTO
	 * */
	public ReserveInfo getResInfo(int resNo);

	
}