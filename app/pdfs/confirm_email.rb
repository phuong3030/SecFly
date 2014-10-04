#encoding: UTF-8

class ConfirmEmail < Prawn::Document
  def initialize(options)
    preprocess_info(options[:ticket_info], options[:order])
    super(options)
  end

  def preprocess_info(ticket_info, order)
    @ticket_info = ticket_info
    @order = order
    @ticket_info[:names] = ticket_info[:names].split(/\d.\d/)[1..2] 
  end

  def header
    image "#{Rails.root}/public/images/pdf/header.png", :position => :center, :fit => [540, 300]
  end

  def names
    text @order.depart_date.to_s
    text @order.return_date.to_s
    @ticket_info[:names].collect do |name|
      text name
    end
    text("RESERVATION CODE: " + @ticket_info[:code])
  end

  def segment
    text @order.depart_date.to_s
    text @order.return_date.to_s
  end

  def price_condition
    text("GIÁ VÉ NET: " + @ticket_info[:price])
    text "ĐIỀU KIỆN CỦA GIÁ VÉ: "
    @ticket_info[:conditions].collect do |con|
      text('- ' + con)
    end
  end

  def note
    text("Code trong booking: ")
    text(@order.from)
    text(@order.to)
    text('VN VIETNAM AIRLINES')
    text("THỜI HẠN IN VÉ: TRƯỚC 19H00 NGÀY HÔM NAY – " + Date.today.strftime('%d.%m.%Y'))
    text "GIÁ, THUẾ, TỶ GIÁ QUY ĐỔI VND TẠI THỜI ĐIỂM IN VÉ."
  end

  def footer
    text "103 Lò Đúc, Hai Bà Trưng, Hà Nội - Việt Nam"
    text "Tel.:  +84 -4 -39717373"
    text "Fax:   +84 -4 -38211270"
    text "Tên tài khoản:  Nacenopto Travel Agency"
    text "Số tài khoản:   111.101 32375102 USD"
    text "111.101 32375021 VNĐ"
    text "Mở tại:"
    text "Ngân hàng TMCP Kỹ Thương Việt Nam"
    text "Đ/C: 15 Đào Duy Từ, Hoàn Kiếm, Hà Nội"
  end

  def ren
    font_path = "#{Rails.root}/public/fonts/"
    font_families.update("sans" => {
      normal: { file: "#{font_path}/ARIALUNI.TTF" }
    })
    font "sans"

    self.header
    self.names
    self.segment
    self.price_condition
    self.note
    self.footer

    self.render_file "#{Rails.root}/ce.pdf"
  end
end
