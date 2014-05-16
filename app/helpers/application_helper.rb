#encoding: utf-8
module ApplicationHelper
  def link_to_lang lang
    curr_lang = (%w{ua ru} - [lang]).first
    path = request.path.gsub(/^\/#{curr_lang}/, "/#{lang}")
    link_to_unless_current t(lang), path
  end

  def ymaps_key
    {
      '192.168.91.128' => 'AFTY2U4BAAAAo3exBgQAMeXxmi9nRjLgkdQec1q9sMCivYQAAAAAAAAAAABvWSNULhl4sFM9BhCw7amlr7SD_g==',
      'm-o.com.ua'     => 'AB1o3E4BAAAApO6jWAMA_zoTSqTL1CVN-MyPrb1agAeq0kYAAAAAAAAAAABihGq0p37H2eoLNm9VqcbcOqTIWw==',
      '192.168.91.132'     => 'AJ6pQVABAAAA3jWgHwQAKFZ5OP3J6eQ20d965Dhyv3Q2WXsAAAAAAAAAAABexbuoC7fNJJYyELaJ6op2IjkM_w=='
    }[request.host] || 'AFTY2U4BAAAAo3exBgQAMeXxmi9nRjLgkdQec1q9sMCivYQAAAAAAAAAAABvWSNULhl4sFM9BhCw7amlr7SD_g=='
  end

  def icon_url p
    p.icon.blank? ? '' : p.icon.url
  end

  def reference_point_json p 
    "'o#{p.id}':{coords:new Array(#{p.coords}),name:'#{p.name.gsub("'","’")}', icon:'#{icon_url(p)}'}"
  end

  def region_json p
    "#{p.id}:{name:'#{p.name}',coords:[#{p.coords}]}"
  end

  def city_json p
     "#{p.id}:{name:'#{p.region.name} / #{p.name}',coords:[#{p.coords}]}"
  end

  def point_json p
    "'p#{p.id}':{coords:new Array(#{p.coords}),name:'#{p.address.gsub("'","’")}'}"
  end

  def point_with_boards_json p
    "{coords:[#{p.coords}],code:'#{p.boards.map do |b| link_to_unless_current(b.code, board_by_code_path(b.code)) end.join(', ')}',address:'#{p.address.gsub("'","’")}',btype:'6x3',multi:'1',city:'#{p.city.name}',region:'#{p.region.name}'}"
  end

  def board_json b
    "{coords:new Array(#{b.coords}),code:'#{b.code}',address:'#{b.address.gsub("'","’")}',btype:'#{b.construction_type}',bsize:'#{b.size}'}"
  end
end
