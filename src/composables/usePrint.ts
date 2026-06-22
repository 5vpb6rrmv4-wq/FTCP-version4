import { ref } from 'vue'

const printTitle = ref('')
const printRows = ref<Array<{ label: string; value: string }>>([])

export function usePrint() {
  function doPrint(title: string, data: Record<string, any>, labels?: Record<string, string>) {
    printTitle.value = title
    printRows.value = Object.entries(data)
      .filter(([_, v]) => v !== undefined && v !== '')
      .map(([k, v]) => ({ label: labels?.[k] || k, value: String(v) }))
    setTimeout(() => window.print(), 100)
  }

  return { printTitle, printRows, doPrint }
}
