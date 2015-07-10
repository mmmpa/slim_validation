require 'rails_helper'

RSpec.describe Entry, type: :model do
  context 'when added invalid slim' do
    it { expect { create(:entry, slim: invalid_slim) }.to raise_exception(ActiveRecord::RecordInvalid) }
    it { expect { create(:entry, slim_no_options: invalid_slim) }.to raise_exception(ActiveRecord::RecordInvalid) }
    it { expect { create(:entry, slim_proc: invalid_slim) }.to raise_exception(ActiveRecord::RecordInvalid) }
    it { expect { create(:entry, slim_attribute: invalid_slim) }.to raise_exception(ActiveRecord::RecordInvalid) }
    it { expect { create(:entry, slim_scope: invalid_slim) }.to raise_exception(ActiveRecord::RecordInvalid) }
  end

  context 'when added valid slim' do
    context 'with no validate options' do
      let(:entry) { create(:entry, slim: valid_slim) }
      it { expect(entry).to be_a(Entry) }
      it { expect(entry.html).to be_nil }
    end

    context 'with no rendering options' do
      let(:entry) { create(:entry, slim_no_options: valid_slim) }
      it { expect(entry).to be_a(Entry) }
      it { expect(entry.html).to eq('<header><h1>title</h1></header><section><p>content</p></section><footer><p>2010/05/09</p></footer>') }
    end

    context 'with rendered proc' do
      let(:entry) { create(:entry, slim_proc: valid_slim) }
      it { expect(entry).to be_a(Entry) }
      it { expect(entry.html).to eq('<header><h1>title</h1></header><section><p>content</p></section><footer><p>2010/05/09</p></footer>') }
    end

    context 'with rendered attribute' do
      let(:entry) { create(:entry, slim_attribute: valid_slim) }
      it { expect(entry).to be_a(Entry) }
      it { expect(entry.html).to eq('<header><h1>title</h1></header><section><p>content</p></section><footer><p>2010/05/09</p></footer>') }
    end

    context 'with scope' do
      let(:entry) { create(:entry, slim_scope: valid_slim) }
      it { expect(entry).to be_a(Entry) }
      it { expect(entry.html).to eq('<header><h1>local value</h1></header><section><p>content</p></section><footer><p>2010/05/09</p></footer>') }
    end
  end
end

def valid_slim
  '
header
  h1= @local_value || "title"
section
  p content
footer
  p 2010/05/09
'
end

def invalid_slim
  '
header
    h1 title
   section
  p content
footer
  p 2010/05/09
'
end