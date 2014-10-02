class ConfirmEmail < Prawn::Document
  def initialize(ticket_info)
    super
  end

  def preprocess_info(ticket_info)
    @ticket_info = ticket_info
  end

  def header
    image "#{Rails.root}/public/images/pdf/header.png", :position => :center, :fit => [540, 300]
  end

  def names
    text @ticket_info.start
    text @ticket_info.end
    @ticket_info.names.collect do |name|
      text name
    end
    text("RESERVATION CODE: " + @ticket_info.code)
  end

  def segment
    text @ticket_info.start
    text @ticket_info.end
  end

  def price_condition
    text "GIÁ VÉ NET: " 
    text "ĐIỀU KIỆN CỦA GIÁ VÉ: "
  end

  def note
    text "Code trong booking: "
    text "THỜI HẠN IN VÉ: TRƯỚC 19H00 NGÀY HÔM NAY – 26.09.2014"
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
    self.render_file "#{Rails.root}/ce.pdf"
  end
end
