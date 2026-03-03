package com.quanzhou.ich.controller;

import com.quanzhou.ich.entity.IchItem;
import com.quanzhou.ich.service.IIchItemService;
import com.quanzhou.ich.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 非遗项目控制器
 */
@RestController
@RequestMapping("/api/ich")
@CrossOrigin
public class IchItemController {

    @Autowired
    private IIchItemService ichItemService;

    @GetMapping("/list")
    public Result<List<IchItem>> list(@RequestParam(required = false) Long categoryId,
                                      @RequestParam(defaultValue = "1") Integer page,
                                      @RequestParam(defaultValue = "10") Integer size) {
        List<IchItem> items = ichItemService.listItems(categoryId, page, size);
        return Result.success(items);
    }

    @GetMapping("/{id}")
    public Result<IchItem> detail(@PathVariable Long id) {
        IchItem item = ichItemService.getById(id);
        return Result.success(item);
    }
}
