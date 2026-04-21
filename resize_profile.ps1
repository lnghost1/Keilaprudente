Add-Type -AssemblyName System.Drawing
function Resize-Image($path, $dest, $width, $quality) {
    if (-Not (Test-Path $path)) { return }
    $img = [System.Drawing.Image]::FromFile($path)
    $ratio = $width / $img.Width
    if ($ratio -ge 1) { 
        $img.Dispose()
        Copy-Item $path $dest -Force
        return 
    }
    $newHeight = [int]($img.Height * $ratio)
    $newImg = New-Object System.Drawing.Bitmap($width, $newHeight)
    $g = [System.Drawing.Graphics]::FromImage($newImg)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($img, 0, 0, $width, $newHeight)
    $g.Dispose()
    $img.Dispose()
    
    $codecs = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders()
    $jpegCodec = $codecs | Where-Object { $_.MimeType -eq 'image/jpeg' }
    $ep = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $ep.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]$quality)
    $newImg.Save($dest, $jpegCodec, $ep)
    $newImg.Dispose()
}

Resize-Image -path "c:\Users\Administrator\Desktop\Keila\Img\DSC_8086 copiar.jpg.jpeg" -dest "c:\Users\Administrator\Desktop\Keila\assets\keila-perfil.jpg" -width 800 -quality 80
