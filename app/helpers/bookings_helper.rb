module BookingsHelper
  def render_seat_checkbox(seat, date)
    content_tag :div, class: seat_class(seat, date), style: seat_style(seat, date) do
      content_tag :div, class: "seat-checkbox #{'unavailable' unless seat.available?(date)}" do
        label_tag do
          check_box_tag(
            "seats[]", 
            seat.id, 
            false, 
            class: "seat-checkbox-input", 
            data: { 
              seat_id: seat.id, 
              seat_number: seat.seat_number, 
              target: "seat-selection.seatCheckbox",
              controller:"hello",
              action: "click->hello#colorChange"
            }, 
            disabled: !seat.available?(date), 
          ) +
          content_tag(:span, seat.seat_number, class: "seat-number")
        end
      end
    end
  end

  def seat_class(seat, date)
    @seat_ids.include?(seat.id) ? 'bg-danger' : 'bg-success'
  end

  def seat_style(seat, date)
    @seat_ids.include?(seat.id) ? 'pointer-events: none;' : ''
  end

  def render_seats(seats, date)
    if seats.any? && date >= Date.today.strftime("%Y-%m-%d")
      content_tag :div, class: "seats-grid" do
        seats.in_groups_of(2, false) do |seat_row|
          concat(content_tag(:div, class: "seat-row") do
            seat_row.compact.each do |seat|
              concat(render_seat_checkbox(seat, date))
            end
          end)
        end
      end
    else
      content_tag :p, "Please Select a valid Date !!!!!!!!!!!!!!!!!!!!!", class: "text-black"
    end
  end
end
