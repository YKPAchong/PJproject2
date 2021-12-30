package com.pj.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pj.domain.ResellBoardVO;
import com.pj.service.ResellBoardService;

import lombok.Setter;

@Controller
@RequestMapping("/resellMarket/resellBoard")
public class ResellBoardController {
	
	@Setter(onMethod_ = @Autowired)
	private ResellBoardService service;
	
	@RequestMapping("/resell")
	public void method01() {
		System.out.println(" resellMarket/resellBoard test");
	}
	
	@RequestMapping("/test")
	public void example() {
		
	}
	
	@RequestMapping("/test2")
	public void example2() {

	}
	
	@RequestMapping("/test3")
	public void example3 () {
		
	}
	
	@GetMapping("/resellBoardList")
	public void list(Model model) {
		// 3. 비즈니스 로직
		//게시물 목록 조회
		List<ResellBoardVO> list = service.getList();
		// 4. add attribute
		model.addAttribute("resellList", list);
		
		// 5 . forward, redirect
		
		//jsp path : /WEB-INF/views/resellMarket/list
		
	}
	
	
	//resellBoard/get?id=10
	@GetMapping({"/resellBoardGet","resellBoardModify"})
	public void get(@RequestParam("id") Integer id, Model model) {
		ResellBoardVO resellBoard = service.get(id);
		
		model.addAttribute("resellBoard", resellBoard);
		
	}
	
	@PostMapping("/resellBoardModify")
	public String  modify(ResellBoardVO resellBoard, RedirectAttributes rttr ) {
		if (service.modify(resellBoard)) {
			rttr.addFlashAttribute("result", resellBoard.getId() + "번 게시글이 수정되었습니다.");
		}
		
		rttr.addAttribute("id", resellBoard.getId());
		/*게시물 조회로 redirect
		return "redirect:/resellMarket/resellBoardList";
		*/
		return "redirect:/resellMarket//resellBoard/resellBoardGet";
	}
	

	@GetMapping("/resellBoardRegister")
	public void register() {
		
	}
	
	@PostMapping("/resellBoardRegister")
	public String register(ResellBoardVO resellBoard, RedirectAttributes rttr) {
		// 2. request 분석 가공 dispatcherServlcet이 해줌
		
	
		// 3. 비즈니스 로직
		service.register(resellBoard);
		
		// 4. add attribute
		rttr.addFlashAttribute("result", resellBoard.getId() +"번 게시글이 등록되었습니다.");
		
		// 5. forward.redirect
		return "redirect:/resellMarket/resellBoard/resellBoardList";
	}
	
	@PostMapping("/ResellBoardRemove")
	public String remove(@RequestParam("id") Integer id, RedirectAttributes rttr) {
		
		if (service.remove(id)) {
			rttr.addFlashAttribute("result", id + "번 게시글이 삭제되었습니다.");
		}
		
		return "redirect:/resellMarket/resellBoard/resellBoardList";
	}
	

}












