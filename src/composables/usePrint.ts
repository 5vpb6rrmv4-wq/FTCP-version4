import { ref } from 'vue'

const printTitle = ref('')
const printRows = ref<Array<{ label: string; value: string }>>([])

export function usePrint() {
  function doPrint(title: string, data: Record<string, any>, labels?: Record<string, string>) {
    const rows = Object.entries(data)
      .filter(([_, v]) => v !== undefined && v !== '')
      .map(([k, v]) => ({ label: labels?.[k] || k, value: String(v) }))

    const timeStr = new Date().toLocaleString('zh-CN')
    const rowsHtml = rows.map(r => `<tr><td class="l">${r.label}</td><td class="v">${r.value}</td></tr>`).join('')

    const html = `<!DOCTYPE html><html><head><meta charset="UTF-8"><title>${title}</title>
<style>
  @page{size:A4;margin:20mm}
  *{margin:0;padding:0;box-sizing:border-box}
  body{font-family:'Microsoft YaHei',sans-serif;color:#000;padding:10mm}
  h2{text-align:center;font-size:18px;color:#153D97;margin-bottom:20px;padding-bottom:10px;border-bottom:2px solid #108B96}
  table{width:100%;border-collapse:collapse}
  td{padding:10px 14px;border-bottom:1px solid #e0e0e0;font-size:13px}
  td.l{width:120px;font-weight:600;color:#475569;background:#f8f9fa}
  td.v{color:#0f172a}
  .foot{text-align:center;margin-top:30px;font-size:10px;color:#999}
</style></head><body>
<h2>${title}</h2><table>${rowsHtml}</table><p class="foot">人才选拔全流程平台 · ${timeStr}</p>
<script>window.onload=function(){setTimeout(function(){window.print()},300)}</script>
</body></html>`

    const w = window.open('', '_blank', 'width=800,height=600')
    if (!w) {
      // popup blocked — fall back to in-page print with @media print
      printTitle.value = title
      printRows.value = rows
      setTimeout(() => window.print(), 200)
      return
    }
    w.document.write(html)
    w.document.close()
  }

  return { printTitle, printRows, doPrint }
}
