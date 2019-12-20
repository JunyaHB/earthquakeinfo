module InformationsHelper

  def earthquakewarning(scale)    
    if scale == nil  || scale < 40
       return false
    else
       return true
    end
  end
      
  def earthquakescale(scale)    
    if scale == 10
      return "震度1"
    elsif scale == 20
      return "震度2"
    elsif scale == 30
      return "震度3"
    elsif scale == 40
      return "震度4"
    elsif scale == 45
      return "震度5弱"
    elsif scale == 50
      return "震度5強"
    elsif scale == 55
      return "震度6弱"
    elsif scale == 60
      return "尊度6強"
    elsif scale == 70
      return "震度7"
    else
      return "不明"
    end
  end
  
  def tsunamiscale(scale)    
    if scale == 'None'
      return '津波の心配なし'
    elsif scale == 'Checking'
      return '津波有無は調査中'
    elsif scale == 'NonEffective'
      return '津波被害の心配なし(若干の海面変動あり)'
    elsif scale == 'Watch'
      return '津波注意報発表中'
    elsif scale == 'Warning'
      return '津波予報発表中'
    else
       return '津波有無は不明'
    end
  end
  
end