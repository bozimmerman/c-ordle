import java.io.*;
import java.util.*;


public class WordTableMaker {

	public WordTableMaker() {
		// TODO Auto-generated constructor stub
	}

	public static void main(final String[] args)
	{
		if(args.length==0)
		{
			System.out.println("WordTableMaker <start address>");
			System.exit(-1);
		}
		final int startOfIndex = Integer.parseInt(args[0]);
		//final int startOfIndex=5520;
		//final int startOfIndex=32768;
		//final int startOfIndex=36352;
		final Set<String> commonness = new TreeSet<String>();
		final StringBuilder str=new StringBuilder("");
		final StringBuilder cstr=new StringBuilder("");
		try
		{
			try(FileInputStream fin = new FileInputStream(new File("5letterwords.txt")))
			{
				while(fin.available()>0)
				{
					final int c=fin.read();
					if(c>0)
						str.append((char)c);
				}
			}
			try(FileInputStream fin = new FileInputStream(new File("common5letterwords.txt")))
			{
				while(fin.available()>0)
				{
					final int c=fin.read();
					if(c>0)
						cstr.append((char)c);
				}
			}
		}
		catch(final IOException e)
		{
			e.printStackTrace();
			return;
		}
		final String[] wlist=str.toString().split(",");
		for(int w=0;w<wlist.length;w++)
			wlist[w]=wlist[w].trim().substring(1,wlist[w].trim().length()-1).toLowerCase().trim();
		System.out.println("number of words="+wlist.length);
		final String[] clist=cstr.toString().split(",");
		for(int w=0;w<clist.length;w++)
			clist[w]=clist[w].trim().substring(1,clist[w].trim().length()-1).toLowerCase().trim();
		System.out.println("number of common words="+clist.length);
		for(final String c : clist)
			commonness.add(c);
		final Map<String,List<String>> theTable=new HashMap<String,List<String>>();
		for(final String w : wlist)
		{
			final String key = w.substring(0,2);
			final String rest = w.substring(2);
			if(!theTable.containsKey(key))
				theTable.put(key, new ArrayList<String>());
			theTable.get(key).add(rest);
		}
		for(final String w : wlist)
		{
			final String key = w.substring(0,2);
			Collections.sort(theTable.get(key));
		}
		final int sizeOfIndex = 26 * 26 * 2;
		final int startOfBlocks=startOfIndex+sizeOfIndex;
		int nextStart=startOfBlocks;
		final Map<String,Long> blockStarts = new HashMap<String,Long>();
		byte[] block;
		int ctr=0;
		try(ByteArrayOutputStream blksOut = new ByteArrayOutputStream())
		{
			for(char fl='a';fl<='z';fl++)
			{
				for(char sl='a';sl<='z';sl++)
				{
					final String key=""+fl+""+sl;
					if(theTable.containsKey(key))
					{
						blockStarts.put(key, Long.valueOf(nextStart));
						nextStart += theTable.get(key).size()*2;
						for(final String s : theTable.get(key))
						{
							final int common = commonness.contains(key+s)?128:0;
							ctr++;
							final int b3=s.charAt(0)-97;
							final int b4=s.charAt(1)-97;
							final int b5=s.charAt(2)-97;
							final int b=(b3<<10)+(b4<<5)+b5;
							final byte b1 = (byte)(((b >> 8)|common) & 0xff);
							final byte b2 = (byte)(b & 0xff);
							System.out.println(ctr+")"+fl+sl+s+": "+b3+","+b4+","+b5+"="+b+":="+(b1&0xff)+","+(b2&0xff));
							blksOut.write(new byte[] { b1,b2});
						}
					}
				}
			}
			block=blksOut.toByteArray();
		}
		catch(final IOException e)
		{
			e.printStackTrace();
			return;
		}
		byte[] header;
		try(ByteArrayOutputStream hedOut = new ByteArrayOutputStream())
		{
			for(char fl='a';fl<='z';fl++)
			{
				for(char sl='a';sl<='z';sl++)
				{
					final String key=""+fl+""+sl;
					if(theTable.containsKey(key))
					{
						final long addr=blockStarts.get(key).longValue() & 0xffff;
						final byte b1 = (byte)((addr % 256) & 0xff);
						final byte b2 = (byte)(((int)Math.round(Math.floor(addr/256.0)))&0xff);
						hedOut.write(new byte[] {b1, b2});
					}
					else
						hedOut.write(new byte[] { 0,0});
				}
			}
			header=hedOut.toByteArray();
		}
		catch(final IOException e)
		{
			e.printStackTrace();
			return;
		}
		try(FileOutputStream fout = new FileOutputStream(new File("dict.bin")))
		{
			final byte b2=(byte)(Math.round(Math.floor(startOfIndex/256.0)) & 0xff);
			final byte b1=(byte)((startOfIndex % 256) & 0xff);
			fout.write(new byte[] {b1, b2});
			fout.write(header);
			fout.write(block);
		}
		catch(final IOException e)
		{
			e.printStackTrace();
		}
		System.out.println("end of table="+Integer.toHexString(nextStart));
	}

}
