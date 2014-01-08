# -*- coding: utf-8 -*-
module MicropostsHelper

  def wrap(content)
    # 非常に長い英単語の場合に自動改行できるようにする
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  private
  def wrap_long_string(text, max_width = 30)
    zero_width_space = "&#8203;" # 連続する英数字の途中で自動改行させるためによく使われる "幅のない空白文字"
    regex = /.{1,#{max_width}}/
    (text.length < max_width) ? text : text.scan(regex).join(zero_width_space)
  end
end
